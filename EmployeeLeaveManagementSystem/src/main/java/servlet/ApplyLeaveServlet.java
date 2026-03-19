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
import java.sql.Date;

public class ApplyLeaveServlet extends HttpServlet {

    private final LeaveDao leaveDao = new LeaveDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("employee") == null) {
            response.sendRedirect("login");
            return;
        }
        request.getRequestDispatcher("applyLeave.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("employee") == null) {
            response.sendRedirect("login");
            return;
        }

        Employee employee = (Employee) session.getAttribute("employee");

        String fromDateStr = request.getParameter("fromDate");
        String toDateStr = request.getParameter("toDate");
        String reason = request.getParameter("reason");

        Date fromDate = Date.valueOf(fromDateStr);
        Date toDate = Date.valueOf(toDateStr);

        // Validate toDate is not before fromDate
        if (toDate.before(fromDate)) {
            request.setAttribute("error", "End date cannot be before start date");
            request.getRequestDispatcher("applyLeave.jsp").forward(request, response);
            return;
        }

        LeaveRequest leaveRequest = new LeaveRequest();
        leaveRequest.setEmployee(employee);
        leaveRequest.setFromDate(fromDate);
        leaveRequest.setToDate(toDate);
        leaveRequest.setReason(reason);
        leaveRequest.setStatus("PENDING");

        leaveDao.applyLeave(leaveRequest);

        response.sendRedirect("viewLeaves?success=true");
    }
}
