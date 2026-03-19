package servlet;

import dao.LeaveDao;
import model.Employee;
import model.LeaveRequest;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class ViewLeaveServlet extends HttpServlet {

    private final LeaveDao leaveDao = new LeaveDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("employee") == null) {
            response.sendRedirect("login");
            return;
        }

        Employee employee = (Employee) session.getAttribute("employee");
        List<LeaveRequest> leaves = leaveDao.getLeavesByEmployee(employee.getId());

        request.setAttribute("leaves", leaves);
        request.getRequestDispatcher("viewLeaves.jsp").forward(request, response);
    }
}
