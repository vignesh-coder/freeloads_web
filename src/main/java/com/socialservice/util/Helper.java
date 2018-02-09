package com.socialservice.util;

import com.socialservice.bean.Post;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class Helper {

    public static List<String> getCategories() {

        List<String> list = new ArrayList<>();
        list.add("Automobile");
        list.add("Blood");
        list.add("Books");
        list.add("Clothes");
        list.add("Electronic Items");
        list.add("Food");
        list.add("Home Appliances");
        list.add("Medicine");
        list.add("Money");
        return list;
    }

    public static boolean isEmpty(String... arr) {

        for (String s : arr) {
            if (s == null || s.isEmpty()) {
                return true;
            }
        }
        return false;
    }

    public static String getTitle() {
        return "FreeLoads";
    }

    public static String getCurrentUser(HttpServletRequest request) {

        HttpSession s = request.getSession();
        return (String) s.getAttribute("logged_user");
    }
    public static String getUserType(HttpServletRequest request) {

        HttpSession s = request.getSession();
        return (String) s.getAttribute("user_type");
    }

    public static void setCurrentUser(HttpServletRequest request, String uid, String userType) {
        HttpSession session = request.getSession();
        session.setAttribute("logged_user", uid);
        session.setAttribute("user_type", userType);
    }

    public static void logout(HttpServletRequest request) throws IOException {
        HttpSession s = request.getSession();
        s.removeAttribute("logged_user");
        s.removeAttribute("user_type");
        s.invalidate();
    }
}
