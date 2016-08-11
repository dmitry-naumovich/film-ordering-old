package by.epam.naumovich.film_ordering.command.impl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import by.epam.naumovich.film_ordering.bean.Review;
import by.epam.naumovich.film_ordering.command.Command;
import by.epam.naumovich.film_ordering.command.util.QueryUtil;
import by.epam.naumovich.film_ordering.service.IFilmService;
import by.epam.naumovich.film_ordering.service.IReviewService;
import by.epam.naumovich.film_ordering.service.ServiceFactory;
import by.epam.naumovich.film_ordering.service.exception.ServiceException;

public class OpenUserReviews implements Command {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		int userId = Integer.parseInt(request.getParameter(RequestAndSessionAttributes.USER_ID));
		
		IReviewService reviewService = ServiceFactory.getInstance().getReviewService();
		IFilmService filmService = ServiceFactory.getInstance().getFilmService();
		
		String query = QueryUtil.createHttpQueryString(request);
		request.getSession(true).setAttribute(RequestAndSessionAttributes.PREV_QUERY, query);
		System.out.println(query);
		
		try {
			List<Review> reviews = reviewService.getReviewsByUserId(userId);
			Collections.reverse(reviews);
			
			List<String> reviewFilmNames = new ArrayList<String>();
			for (Review r : reviews) {
				reviewFilmNames.add(filmService.getFilmByID(r.getFilmId()).getName());
			}
			
			request.setAttribute(RequestAndSessionAttributes.REVIEWS, reviews);
			request.setAttribute(RequestAndSessionAttributes.FILM_NAMES, reviewFilmNames);
			
			String url = response.encodeRedirectURL(JavaServerPageNames.REVIEWS_PAGE);
			request.getRequestDispatcher(url).forward(request, response);
		}
		catch (ServiceException e) {
			request.getRequestDispatcher(JavaServerPageNames.ERROR_PAGE).forward(request, response);
		}
		
		
	}

}