package by.epam.naumovich.film_ordering.command.impl.news;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import by.epam.naumovich.film_ordering.command.Command;
import by.epam.naumovich.film_ordering.command.util.ErrorMessages;
import by.epam.naumovich.film_ordering.command.util.JavaServerPageNames;
import by.epam.naumovich.film_ordering.command.util.LogMessages;
import by.epam.naumovich.film_ordering.command.util.QueryUtil;
import by.epam.naumovich.film_ordering.command.util.RequestAndSessionAttributes;
import by.epam.naumovich.film_ordering.command.util.SuccessMessages;
import by.epam.naumovich.film_ordering.service.INewsService;
import by.epam.naumovich.film_ordering.service.ServiceFactory;
import by.epam.naumovich.film_ordering.service.exception.ServiceException;
import by.epam.naumovich.film_ordering.service.exception.news.EditNewsServiceException;

public class EditNews implements Command {

	private static final Logger logger = LogManager.getLogger(Logger.class.getName());
	private static final int MAX_MEMORY_SIZE = 1024 * 1024 * 2;
    private static final int MAX_REQUEST_SIZE = 1024 * 1024 * 6;
	private static final String UPLOAD_FOLDER = "D:/java-work/film-ordering/WebContent/img/news/";
	private static final String UTF_8 = "UTF-8";
	private static final String REPOSITORY = "java.io.tmpdir";
	private static final String NEWS_IMG_FILE_NAME = "01.jpg";
	
	@SuppressWarnings("unchecked")
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		HttpSession session = request.getSession(true);
		String query = QueryUtil.createHttpQueryString(request);
		session.setAttribute(RequestAndSessionAttributes.PREV_QUERY, query);
		System.out.println(query);
		
		int newsID = Integer.parseInt(request.getParameter(RequestAndSessionAttributes.NEWS_ID));
		if (session.getAttribute(RequestAndSessionAttributes.AUTHORIZED_USER) == null |
				!Boolean.parseBoolean(session.getAttribute(RequestAndSessionAttributes.IS_ADMIN).toString())) {
			request.setAttribute(RequestAndSessionAttributes.ERROR_MESSAGE, ErrorMessages.EDIT_NEWS_RESTRICTION);
			request.getRequestDispatcher("/Controller?command=open_single_news&newsID=" + newsID).forward(request, response);
		}
		else {
			String title = null;
			String text = null;
			FileItem imgItem = null;
			File image = null;
			try {
				if (ServletFileUpload.isMultipartContent(request)) {
					
					DiskFileItemFactory factory = new DiskFileItemFactory();
				    factory.setSizeThreshold(MAX_MEMORY_SIZE);
				    factory.setRepository(new File(System.getProperty(REPOSITORY)));
				    ServletFileUpload  fileUpload = new ServletFileUpload(factory);
				    fileUpload.setSizeMax(MAX_REQUEST_SIZE);
				    List<FileItem> items = fileUpload.parseRequest(request);
				    Iterator<FileItem> iter = items.iterator();
				    
				    while (iter.hasNext()) {
				        FileItem item = iter.next();
				        if (!item.isFormField()) {
				        	if (item.getName() != null && !item.getName().isEmpty()) {
					        	imgItem = item;
				        		String folderFileName = new File(item.getName()).getName();
				        		String folderFilePath = UPLOAD_FOLDER + File.separator + folderFileName;
				        		image = new File(folderFilePath);
				        		break;
				        	}
				        } else {
				        	switch (item.getFieldName()) {
				        	case RequestAndSessionAttributes.NEWS_TITLE:
				        		title = item.getString(UTF_8);
				        		break;
				        	case RequestAndSessionAttributes.NEWS_TEXT:
				        		text = item.getString(UTF_8);
				        		break;
				        	}
				        }
				    }
				}
				INewsService newsService = ServiceFactory.getInstance().getNewsService();
				newsService.editNews(newsID, title, text);
				if (image != null) {
					try {
						imgItem.write(image);
					    Files.move(image.toPath(), new File(UPLOAD_FOLDER + newsID + "/" + File.separator + NEWS_IMG_FILE_NAME).toPath(), java.nio.file.StandardCopyOption.REPLACE_EXISTING);
					} catch (IOException e) {
						logger.error(String.format(LogMessages.EXCEPTION_IN_COMMAND, e.getClass().getSimpleName(), this.getClass().getSimpleName(), e.getMessage()));
						request.setAttribute(RequestAndSessionAttributes.ERROR_MESSAGE, e.getMessage());
					}
				}
				
				logger.debug(String.format(LogMessages.NEWS_EDITED, newsID));
				request.setAttribute(RequestAndSessionAttributes.SUCCESS_MESSAGE, SuccessMessages.NEWS_EDITED);
				request.getRequestDispatcher("/Controller?command=open_single_news&newsID=" + newsID).forward(request, response);
			} catch (EditNewsServiceException e) {
				logger.error(String.format(LogMessages.EXCEPTION_IN_COMMAND, e.getClass().getSimpleName(), this.getClass().getSimpleName(), e.getMessage()));
				request.setAttribute(RequestAndSessionAttributes.ERROR_MESSAGE, e.getMessage());
				request.getRequestDispatcher("/Controller?command=open_news_edit_page&newsID=" + newsID).forward(request, response);
			} catch (ServiceException e) {
				logger.error(String.format(LogMessages.EXCEPTION_IN_COMMAND, e.getClass().getSimpleName(), this.getClass().getSimpleName(), e.getMessage()));
				request.setAttribute(RequestAndSessionAttributes.ERROR_MESSAGE, e.getMessage());
				request.getRequestDispatcher(JavaServerPageNames.ERROR_PAGE).forward(request, response);
			} catch (Exception e) {
				logger.error(String.format(LogMessages.EXCEPTION_IN_COMMAND, e.getClass().getSimpleName(), this.getClass().getSimpleName(), e.getMessage()));
				request.setAttribute(RequestAndSessionAttributes.ERROR_MESSAGE, e.getMessage());
				request.getRequestDispatcher(JavaServerPageNames.ERROR_PAGE).forward(request, response);
			}
		}

	}

}
