package by.epam.naumovich.film_ordering.service.exception;

public class GetReviewsServiceException extends ServiceException {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public GetReviewsServiceException(String msg) {
		super(msg);
	}
	
	public GetReviewsServiceException(String msg, Exception e) {
		super(msg, e);
	}

}