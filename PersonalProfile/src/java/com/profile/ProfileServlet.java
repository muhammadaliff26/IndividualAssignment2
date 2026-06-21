package com.profile;

import Profile.DatabaseConnection;
import Profile.ProfileBean;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String fullName = request.getParameter("fullName");
        String studentId = request.getParameter("studentId");
        String program = request.getParameter("program");
        String email = request.getParameter("email");
        String introduction = request.getParameter("introduction");

        String[] hobbiesArray = request.getParameterValues("hobbies");
        String hobbies = (hobbiesArray != null) ? String.join(", ", hobbiesArray) : "No hobbies selected";

        ProfileBean profile = new ProfileBean(studentId, fullName, program, email, hobbies, introduction);
        boolean isInserted = DatabaseConnection.insertProfile(profile);

        request.setAttribute("fullName", fullName);
        request.setAttribute("studentId", studentId);
        request.setAttribute("program", program);
        request.setAttribute("email", email);
        request.setAttribute("hobbies", hobbies);
        request.setAttribute("introduction", introduction);

        if (isInserted) {
            request.setAttribute("message", "Profile saved successfully to database!");
        } else {
            request.setAttribute("message", "Error: Could not save profile to database");
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("result.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("index.html");
    }
}