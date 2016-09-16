package by.epam.naumovich.film_ordering.command.impl.film;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import by.epam.naumovich.film_ordering.bean.Film;
import by.epam.naumovich.film_ordering.bean.Order;
import by.epam.naumovich.film_ordering.command.Command;
import by.epam.naumovich.film_ordering.command.util.JavaServerPageNames;
import by.epam.naumovich.film_ordering.command.util.QueryUtil;
import by.epam.naumovich.film_ordering.command.util.RequestAndSessionAttributes;
import by.epam.naumovich.film_ordering.service.IFilmService;
import by.epam.naumovich.film_ordering.service.IOrderService;
import by.epam.naumovich.film_ordering.service.ServiceFactory;
import by.epam.naumovich.film_ordering.service.exception.ServiceException;
import by.epam.naumovich.film_ordering.service.exception.film.GetFilmsServiceException;
import by.epam.naumovich.film_ordering.service.exception.order.GetOrdersServiceException;

public class OpenAllFilms implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		HttpSession session = request.getSession(true);
		String query = QueryUtil.createHttpQueryString(request);
		session.setAttribute(RequestAndSessionAttributes.PREV_QUERY, query);
		System.out.println(query);
		
		try {
			IFilmService filmService = ServiceFactory.getInstance().getFilmService();
			IOrderService orderService = ServiceFactory.getInstance().getOrderService();
			
			Set<Film> films = filmService.getAllFilms();
			request.setAttribute(RequestAndSessionAttributes.FILMS, films);
			
			if (session.getAttribute(RequestAndSessionAttributes.AUTHORIZED_USER) != null) {
				if (!Boolean.parseBoolean(session.getAttribute(RequestAndSessionAttributes.IS_ADMIN).toString())) {
					int userID = Integer.parseInt(session.getAttribute(RequestAndSessionAttributes.USER_ID).toString());
					try {
						List<Order> orders = orderService.getOrdersByUserId(userID);
						List<Integer> orderFilmIDs = new ArrayList<Integer>();
						for (Order o : orders) {
							orderFilmIDs.add(o.getFilmId());
						}
						request.setAttribute(RequestAndSessionAttributes.USER_ORDER_FILM_IDS, orderFilmIDs);
					} catch (GetOrdersServiceException e) {
						request.setAttribute(RequestAndSessionAttributes.USER_ORDER_FILM_IDS, Collections.emptyList());
					}
				}
			}
			
			request.getRequestDispatcher(JavaServerPageNames.FILMS_JSP_PAGE).forward(request, response);
			
		} catch (GetFilmsServiceException e) {
			request.setAttribute(RequestAndSessionAttributes.ERROR_MESSAGE, e.getMessage());
			request.getRequestDispatcher(JavaServerPageNames.FILMS_JSP_PAGE).forward(request, response);
		}
		catch (ServiceException e) {
			request.setAttribute(RequestAndSessionAttributes.ERROR_MESSAGE, e.getMessage());
			request.getRequestDispatcher(JavaServerPageNames.ERROR_PAGE).forward(request, response);
		}
	}

}