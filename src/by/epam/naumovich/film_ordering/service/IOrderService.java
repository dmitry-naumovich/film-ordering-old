package by.epam.naumovich.film_ordering.service;

import java.util.List;

import by.epam.naumovich.film_ordering.bean.Order;
import by.epam.naumovich.film_ordering.service.exception.ServiceException;

public interface IOrderService {

	void addOrder(Order order) throws ServiceException;
	void deleteOrder(Order order) throws ServiceException;
	
	List<Order> getOrdersByUserId(int id) throws ServiceException;
	List<Order> getOrdersByFilmId(int id) throws ServiceException;
	List<Order> getAllOrders() throws ServiceException;
}