package by.epam.naumovich.film_ordering.service.exception.user;

import by.epam.naumovich.film_ordering.service.exception.ServiceException;

public class BanUserServiceException extends ServiceException {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public BanUserServiceException(String msg, Exception e) {
		super(msg, e);
		// TODO Auto-generated constructor stub
	}

	public BanUserServiceException(String msg) {
		super(msg);
		// TODO Auto-generated constructor stub
	}

}