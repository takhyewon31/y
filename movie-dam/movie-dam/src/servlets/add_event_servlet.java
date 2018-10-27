package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import modal.CalendarDTO;

/**
 * 
 * Servlet implementation class add_event_servlet
 */

@WebServlet(name = "add_event_servlet", urlPatterns = {"/add_event_servlet"})
public class add_event_servlet extends HttpServlet {

	 protected void doPost(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {
	        try {
	            CalendarDTO cd = new CalendarDTO();
	            cd.setId(Integer.parseInt(request.getParameter("id")));
	            cd.setTitle(request.getParameter("title"));
	            cd.setStart(request.getParameter("start"));
	            cd.setEnd(request.getParameter("end"));
	            
	            Class.forName("com.mysql.jdbc.Driver");
	            Connection con = DriverManager.getConnection("java:comp/env", "miso", "");
	            int success = con.createStatement().executeUpdate("INSERT INTO `events`(`id`, `title`, `start`, `end`) VALUES ('" + cd.getId() + "','" + cd.getTitle() + "','" + cd.getStart() + "','" + cd.getEnd() + "')");
	            if (success > 0) {
	                response.sendRedirect("add_event.jsp?message=succ");
	            }
	        } catch (ClassNotFoundException ex) {
	            Logger.getLogger(CalendarJsonServlet.class.getName()).log(Level.SEVERE, null, ex);
	        } catch (SQLException ex) {
	            Logger.getLogger(CalendarJsonServlet.class.getName()).log(Level.SEVERE, null, ex);
	        }
	    }

}
