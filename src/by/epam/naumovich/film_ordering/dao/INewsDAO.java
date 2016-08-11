package by.epam.naumovich.film_ordering.dao;

import java.util.List;

import by.epam.naumovich.film_ordering.bean.News;
import by.epam.naumovich.film_ordering.dao.exception.DAOException;

public interface INewsDAO {

	void addNews(News news) throws DAOException;
	void deleteNews(News news) throws DAOException;
	List<News> getAllNews() throws DAOException;
	News getNewsById(int id) throws DAOException;
	List<News> getNewsByYear(int year) throws DAOException;
	List<News> getNewsByMonthAndYear(int month, int year) throws DAOException;

}
