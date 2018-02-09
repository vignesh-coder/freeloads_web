package com.socialservice.util;

import com.socialservice.bean.Post;
import com.socialservice.bean.User;
import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import javax.servlet.http.HttpServletRequest;

public class DBActions {
    
    public static boolean savePost(Post post) throws SQLException, ClassNotFoundException {
        
        Connection con = DBConnection.getConnection();
        if (con != null) {
            
            String sql = "insert into posts (userid, category, type, title, description, address, contact,images)values(?,?,?,?,?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(sql);
            
            ps.setString(1, post.getUserID());
            ps.setString(2, post.getCategory());
            ps.setString(3, post.getType());
            ps.setString(4, post.getTitle());
            ps.setString(5, post.getDesc());
            ps.setString(6, post.getAddress());
            ps.setString(7, post.getContact());
            String img = "";
            if (!post.getImages().isEmpty()) {
                
                for (String s : post.getImages()) {
                    img += s + ",";
                }
                img = img.substring(0, img.length() - 1);
            }
            ps.setString(8, img);
            
            return ps.executeUpdate() == 1;
            
        } else {
            return false;
        }
        
    }
    
    public static List<Post> getPosts(String query) throws ClassNotFoundException, SQLException {
        
        List<Post> list = new ArrayList<>();
        
        Connection con = DBConnection.getConnection();
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery(query);
        while (rs.next()) {
            Post post = new Post();
            post.setPID(rs.getInt(1));
            post.setUserID(rs.getString(2));
            post.setCategory(rs.getString(3));
            post.setType(rs.getString(4));
            post.setTitle(rs.getString(5));
            post.setDesc(rs.getString(6));
            post.setAddress(rs.getString(7));
            post.setContact(rs.getString(8));
            List<String> img = Arrays.asList(rs.getString(9).split(","));
            post.setImages(img);
            post.setTimestamp(rs.getLong(10));
            post.setVerified(rs.getInt(11) > 0);
            list.add(post);
        }
        return list;
        
    }
    public static boolean publishPost(String pid) throws SQLException, ClassNotFoundException{
    
        String query = "UPDATE posts SET verified=true where pid=?";
        Connection con = DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement(query);
        ps.setInt(1, Integer.parseInt(pid));
        return ps.executeUpdate()>0;
    }
    public static Post getPost(String pid) throws ClassNotFoundException, SQLException {
        List<Post> posts = getPosts("Select * from posts where pid=" + pid);
        Post post = null;
        if (!posts.isEmpty()) {
            post = posts.get(0);
        }
        
        return post;
    }
    
    public static User getUser(String uid) throws ClassNotFoundException, SQLException {
        Connection con = DBConnection.getConnection();
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("select * from users where uid=" + uid);
        User user = null;
        if (rs.next()) {
            user = new User();
            user.setUid(Integer.parseInt(uid));
            user.setName(rs.getString(2));
            user.setEmail(rs.getString(3));
            user.setBio(rs.getString(4));
        }
        return user;
    }
    
    public static void deletePost(HttpServletRequest request, String pid, String uid) throws ClassNotFoundException, SQLException {
        
        if (pid == null) {
            return;
        }
        if (pid.isEmpty()) {
            return;
        }
        if (uid == null) {
            return;
        }
        Post post = getPost(pid);
        if (post != null) {
            
            Connection con = DBConnection.getConnection();
            String query = "delete from posts where pid = ?";
            PreparedStatement preparedStmt = con.prepareStatement(query);
            
            if (!uid.equals("-1")) {
                query += " and userid = ?";
                preparedStmt = con.prepareStatement(query);
                preparedStmt.setInt(2, Integer.parseInt(uid));
            }
            preparedStmt.setInt(1, Integer.parseInt(pid));
            
            if (preparedStmt.executeUpdate() > 0) {
                
                String path = request.getSession().getServletContext().getRealPath("/")
                        + Helper.getTitle()
                        + "/user_data/"
                        + post.getUserID()
                        + "/";
                for (String s : post.getImages()) {
                    
                    File file = new File(path + s);
                    file.delete();
                }
            }
        }
        
    }
}
