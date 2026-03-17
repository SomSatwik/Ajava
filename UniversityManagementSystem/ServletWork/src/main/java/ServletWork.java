import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/Task1Servlet")
public class ServletWork extends HttpServlet {

    // Common method to handle both GET and POST requests
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println("<html><body style='font-family: Arial; padding: 20px;'>");

        // --- SECTION A: GET TASKS ---
        String name = request.getParameter("userName");
        if (name != null) {
            out.println("<h2>Task 1: Welcome " + name + " (" + request.getParameter("userEmail") + ")</h2>");
        }

        String n1 = request.getParameter("num1");
        if (n1 != null) {
            int result = Integer.parseInt(n1) + Integer.parseInt(request.getParameter("num2"));
            out.println("<h2>Task 2: Addition Result = " + result + "</h2>");
        }

        String cel = request.getParameter("celsius");
        if (cel != null) {
            double f = (Double.parseDouble(cel) * 9 / 5) + 32;
            out.println("<h2>Task 3: Fahrenheit = " + f + "</h2>");
        }

        String sName = request.getParameter("sName");
        if (sName != null) {
            out.println("<h2>Task 4 Profile: " + sName + " | Roll: " + request.getParameter("roll") + " | Course: " + request.getParameter("course") + "</h2>");
        }

        String val1 = request.getParameter("val1");
        if (val1 != null) {
            out.println("<h2>Task 5: Greater is " + Math.max(Integer.parseInt(val1), Integer.parseInt(request.getParameter("val2"))) + "</h2>");
        }

        String principal = request.getParameter("principal");
        if (principal != null) {
            double si = (Double.parseDouble(principal) * Double.parseDouble(request.getParameter("rate")) * Double.parseDouble(request.getParameter("time"))) / 100;
            out.println("<h2>Task 6: Simple Interest = " + si + "</h2>");
        }

        String hId = request.getParameter("hiddenUserId");
        if (hId != null) {
            out.println("<h2>Task 7: Hidden ID Found: " + hId + "</h2>");
        }

        String course = request.getParameter("courseSelection");
        if (course != null) {
            out.println("<h2>Task 8: Enrolled in " + course + "</h2>");
        }

        String[] getSkills = request.getParameterValues("getSkills");
        if (getSkills != null) {
            out.println("<h2>Task 9 Skills: " + String.join(", ", getSkills) + "</h2>");
        }

       //SECTION-B
        String lUser = request.getParameter("loginUser");
        if (lUser != null) {
            String pass = request.getParameter("loginPass");
            if (lUser.equals("admin") && pass.equals("123")) {
                out.println("<h2 style='color:green;'>Task B1: Login Success!</h2>");
            } else {
                out.println("<h2 style='color:red;'>Task B1: Login Failed!</h2>");
            }
        }

        String rName = request.getParameter("regName");
        if (rName != null) {
            out.println("<h2>Task B2: Student Registered: " + rName + " (" + request.getParameter("gender") + ")</h2>");
        }

        String m1 = request.getParameter("mult1");
        if (m1 != null) {
            out.println("<h2>Task B3: Multiplication = " + (Integer.parseInt(m1) * Integer.parseInt(request.getParameter("mult2"))) + "</h2>");
        }

        String fbName = request.getParameter("fbName");
        if (fbName != null) {
            out.println("<h2>Task B4: Thank you " + fbName + " for your feedback!</h2>");
        }

        String eName = request.getParameter("empName");
        if (eName != null) {
            out.println("<h2>Task B5: Employee Details</h2><table border='1'><tr><th>Name</th><th>Salary</th><th>Dept</th></tr>");
            out.println("<tr><td>" + eName + "</td><td>" + request.getParameter("empSalary") + "</td><td>" + request.getParameter("empDept") + "</td></tr></table>");
        }

        String[] hobbies = request.getParameterValues("hobbies");
        if (hobbies != null) {
            out.println("<h2>Task B6 Hobbies: " + String.join(", ", hobbies) + "</h2>");
        }

        String vField = request.getParameter("vField");
        if (vField != null) {
            if (vField.trim().isEmpty()) {
                out.println("<h2 style='color:red;'>Task B7 Error: Field cannot be empty!</h2>");
            } else {
                out.println("<h2 style='color:green;'>Task B7: Field Validated!</h2>");
            }
        }

        if ("redirect".equals(request.getParameter("action"))) {
            response.sendRedirect("https://www.google.com"); // Task B8: Redirecting
            return;
        }

        String rLen = request.getParameter("rectLength");
        if (rLen != null) {
            out.println("<h2>Task B9: Rectangle Area = " + (Integer.parseInt(rLen) * Integer.parseInt(request.getParameter("rectWidth"))) + "</h2>");
        }

        // Task B10 & A10: Reporting Method
        out.println("<p>Final Task: The HTTP method used was <b>" + request.getMethod() + "</b></p>");

        out.println("<br><a href='index.html'>Back to Forms</a></body></html>");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response); // Common logic
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response); // Common logic
    }
}