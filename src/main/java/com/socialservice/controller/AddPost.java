package com.socialservice.controller;

import com.socialservice.bean.Post;
import com.socialservice.util.DBActions;
import com.socialservice.util.Helper;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.DefaultFileItemFactory;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class AddPost extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Post post = new Post();
        String userID = Helper.getCurrentUser(request);
        StringBuilder msg = new StringBuilder();

        String contentType = request.getContentType();

        new PrintWriter(response.getOutputStream()).print(contentType);

        if (userID != null) {

            if (contentType != null && contentType.contains("multipart/form-data")) {
                try {

                    post.setUserID(userID);

                    int MAX_MEM_SIZE = 10000 * 1024;
                    int MAX_FILE_SIZE = 10000 * 1024;

                    List<String> urlList = new ArrayList<>();

                    String uploadPath = request.getSession().getServletContext().getRealPath("/") + Helper.getTitle() + "/user_data/" + userID + "/";
                    File repositary = new File("c:\\temp");
                    DiskFileItemFactory fileItemFactory = new DefaultFileItemFactory(MAX_MEM_SIZE, repositary);
                    ServletFileUpload fileUpload = new ServletFileUpload(fileItemFactory);

                    fileUpload.setSizeMax(MAX_FILE_SIZE);

                    List fileItems = fileUpload.parseRequest(request);
                    Iterator itr = fileItems.iterator();

                    long timestamp = System.currentTimeMillis();
                    while (itr.hasNext()) {

                        FileItem fi = (FileItem) itr.next();

                        if (!fi.isFormField()) {
                            if (fi.getName() == null || fi.getName().isEmpty()) {
                                // No file was been selected.
                            }

                            if (fi.getSize() == 0) {
                                // No file was been selected, or it was an empty file.
                            } else {

                                String fileName = "post" + (timestamp++) + ".jpg";
                                File file = new File(uploadPath, fileName);
                                file.getParentFile().mkdirs();
                                fi.write(file);
                                urlList.add(fileName);
                            }
                        }
                    }

                    post.setAddress(getFieldValue(fileItems, "address"));
                    post.setCategory(getFieldValue(fileItems, "category"));
                    post.setContact(getFieldValue(fileItems, "contact"));
                    post.setDesc(getFieldValue(fileItems, "desc"));
                    post.setTitle(getFieldValue(fileItems, "title"));
                    post.setType(getFieldValue(fileItems, "type"));

                    post.setImages(urlList);

                    if (DBActions.savePost(post)) {
                        response.sendRedirect("post-added.jsp");
                    } else {
                        msg.append("post not added, try again.").append("\n");
                    }

                } catch (Exception ex) {
                    msg.append(ex.getMessage()).append("\n");
                }
            } else {
                msg.append("does not multipart/form-data").append("\n");
            }
        } else {
            response.sendRedirect("auth.jsp?required=login&redirect=create-post.jsp");
        }
        if (!response.isCommitted()) {
            response.sendRedirect("error.jsp?" + msg);
        }
    }

    protected String getFieldValue(List<FileItem> formItems, String fieldName) {
        String value = null;

        for (FileItem fi : formItems) {
            if (fi.isFormField()) {
                if (fi.getFieldName().equals(fieldName)) {
                    value = fi.getString();
                }
            }
        }

        return value;
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processRequest(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("index.jsp");
    }
}
