package by.epam.naumovich.film_ordering.command.impl.user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import by.epam.naumovich.film_ordering.command.Command;
import by.epam.naumovich.film_ordering.command.util.ErrorMessages;
import by.epam.naumovich.film_ordering.command.util.JavaServerPageNames;
import by.epam.naumovich.film_ordering.command.util.RequestAndSessionAttributes;
import by.epam.naumovich.film_ordering.command.util.SuccessMessages;
import by.epam.naumovich.film_ordering.service.IUserService;
import by.epam.naumovich.film_ordering.service.ServiceFactory;
import by.epam.naumovich.film_ordering.service.exception.ServiceException;
import by.epam.naumovich.film_ordering.service.exception.user.DiscountServiceException;

public class AddDiscount implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		HttpSession session = request.getSession(true);
		int userID = Integer.parseInt(request.getParameter(RequestAndSessionAttributes.USER_ID));
		
		if (session.getAttribute(RequestAndSessionAttributes.AUTHORIZED_USER) == null) {
			request.setAttribute(RequestAndSessionAttributes.ERROR_MESSAGE, ErrorMessages.ADD_DISCOUNT_RESTRICTION);
			request.getRequestDispatcher(JavaServerPageNames.LOGINATION_PAGE).forward(request, response);
		}
		else if (!Boolean.parseBoolean(session.getAttribute(RequestAndSessionAttributes.IS_ADMIN).toString())) {
			request.setAttribute(RequestAndSessionAttributes.ERROR_MESSAGE, ErrorMessages.ADD_DISCOUNT_RESTRICTION);
			request.getRequestDispatcher("/Controller?command=open_user_profile&userID=" + userID).forward(request, response);
		}
		else {
			String amount = request.getParameter(RequestAndSessionAttributes.AMOUNT);
			String endDate = request.getParameter(RequestAndSessionAttributes.END_DATE);
			String endTime = request.getParameter(RequestAndSessionAttributes.END_TIME);
			
			try {
				IUserService userService = ServiceFactory.getInstance().getUserService();
				userService.addDiscount(userID, amount, endDate, endTime);
				request.setAttribute(RequestAndSessionAttributes.SUCCESS_MESSAGE, SuccessMessages.DISCOUNT_ADDED);
				Thread.sleep(1000);
				request.getRequestDispatcher("/Controller?command=open_user_profile&userID=" + userID).forward(request, response);
			} catch (DiscountServiceException e) {
				request.setAttribute(RequestAndSessionAttributes.ERROR_MESSAGE, e.getMessage());
				request.getRequestDispatcher("/Controller?command=open_user_profile&userID=" + userID).forward(request, response);
			} catch (ServiceException | InterruptedException e) {
				request.setAttribute(RequestAndSessionAttributes.ERROR_MESSAGE, e.getMessage());
				request.getRequestDispatcher(JavaServerPageNames.ERROR_PAGE).forward(request, response);
			}
		}

	}

}