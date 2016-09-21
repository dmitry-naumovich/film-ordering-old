package by.epam.naumovich.film_ordering.dao.impl;

import java.sql.Date;
import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.LinkedHashSet;
import java.util.Set;

import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

import by.epam.naumovich.film_ordering.bean.Order;
import by.epam.naumovich.film_ordering.dao.DAOFactory;
import by.epam.naumovich.film_ordering.dao.IOrderDAO;
import by.epam.naumovich.film_ordering.dao.exception.DAOException;

/**
 * Tests DAO layer methods overridden in MySQLOrderDAO class in a way of comparing expected and actual results with the help of JUnit 4 framework.
 * 
 * @author Dmitry Naumovich
 * @version 1.0
 *
 */
public class MySQLOrderDAOTest {


	/**
	 * Database type used in this test suite.
	 * 
	 */
	private static final String MYSQL = "mysql";
	/**
	 * This object will be compared to the actual object taken from the DAO layer.
	 * 
	 */
	private Order expectedOrder;
	
	/**
	 * Executes every time before a single method call and initializes expected Order object.
	 * 
	 */
	@Before
	public void initTestOrder() {
		expectedOrder = new Order();
		expectedOrder.setUserId(1);
		expectedOrder.setFilmId(5);
		expectedOrder.setDate(Date.valueOf(LocalDate.now()));
		expectedOrder.setTime(Time.valueOf(LocalTime.now()));
		expectedOrder.setPrice(10.0f);
		expectedOrder.setDiscount(10);
		expectedOrder.setPayment(9.0f);
	}
	
	/**
	 * Adds expectedOrder to the data source via DAO layer, gets it back and compares two results.
	 * Tests if the order was really added.
	 * 
	 * @throws DAOException
	 */
	@Test
	public void addOrder() throws DAOException {
		DAOFactory daoFactory = DAOFactory.getDAOFactory(MYSQL);
		IOrderDAO dao = daoFactory.getOrderDAO();
		
		int orderNum = dao.addOrder(expectedOrder);
        Order actualOrder = dao.getOrderByOrderNum(orderNum);
        dao.deleteOrder(orderNum);

        Assert.assertEquals(expectedOrder.getUserId(), actualOrder.getUserId());
        Assert.assertEquals(expectedOrder.getFilmId(), actualOrder.getFilmId());
        Assert.assertEquals(expectedOrder.getDate(), actualOrder.getDate());
        Assert.assertEquals(expectedOrder.getTime(), actualOrder.getTime());
        Assert.assertEquals(expectedOrder.getPrice(), actualOrder.getPrice(), 0.00f);
        Assert.assertEquals(expectedOrder.getDiscount(), actualOrder.getDiscount());
        Assert.assertEquals(expectedOrder.getPayment(), actualOrder.getPayment(), 0.00f);	
	}
	
	/**
	 * Adds expectedOrder to the data source via DAO layer, deletes it and then tries to get it back expecting the null result.
	 * Tests if the order was really deleted.
	 * 
	 * @throws DAOException
	 */
	@Test
	public void deleteOrder() throws DAOException {
		DAOFactory daoFactory = DAOFactory.getDAOFactory(MYSQL);
		IOrderDAO dao = daoFactory.getOrderDAO();
		
		int orderNum = dao.addOrder(expectedOrder);
        dao.deleteOrder(orderNum);
        Order actualOrder = dao.getOrderByOrderNum(orderNum);
		
        Assert.assertNull(actualOrder);
	}
	
	/**
	 * Adds expectedOrder to the data source via DAO layer, gets it back by ID and compares two results.
	 * Tests if the valid order entity is returned by orderNum.
	 * 
	 * @throws DAOException
	 */
	@Test
	public void getOrderByOrderNum() throws DAOException {
		DAOFactory daoFactory = DAOFactory.getDAOFactory(MYSQL);
		IOrderDAO dao = daoFactory.getOrderDAO();
		
		int orderNum = dao.addOrder(expectedOrder);
        Order actualOrder = dao.getOrderByOrderNum(orderNum);
        dao.deleteOrder(orderNum);
        
        Assert.assertEquals(expectedOrder.getUserId(), actualOrder.getUserId());
        Assert.assertEquals(expectedOrder.getFilmId(), actualOrder.getFilmId());
        Assert.assertEquals(expectedOrder.getDate(), actualOrder.getDate());
        Assert.assertEquals(expectedOrder.getTime(), actualOrder.getTime());
        Assert.assertEquals(expectedOrder.getPrice(), actualOrder.getPrice(), 0.00f);
        Assert.assertEquals(expectedOrder.getDiscount(), actualOrder.getDiscount());
        Assert.assertEquals(expectedOrder.getPayment(), actualOrder.getPayment(), 0.00f);	
	}
	
	/**
	 * Adds expectedOrder to the data source via DAO layer, gets it back by ID and compares two results.
	 * Tests if the valid order entity is returned by user and film IDs.
	 * Then tests if null object is returned again by same IDs after it deletion.
	 * 
	 * @throws DAOException
	 */
	@Test
	public void getOrderByUserAndFilmId() throws DAOException {
		DAOFactory daoFactory = DAOFactory.getDAOFactory(MYSQL);
		IOrderDAO dao = daoFactory.getOrderDAO();
		
		int orderNum = dao.addOrder(expectedOrder);
        Order actualOrder = dao.getOrderByUserAndFilmId(expectedOrder.getUserId(), expectedOrder.getFilmId());
        dao.deleteOrder(orderNum);
        
        Assert.assertEquals(expectedOrder.getUserId(), actualOrder.getUserId());
        Assert.assertEquals(expectedOrder.getFilmId(), actualOrder.getFilmId());
        Assert.assertEquals(expectedOrder.getDate(), actualOrder.getDate());
        Assert.assertEquals(expectedOrder.getTime(), actualOrder.getTime());
        Assert.assertEquals(expectedOrder.getPrice(), actualOrder.getPrice(), 0.00f);
        Assert.assertEquals(expectedOrder.getDiscount(), actualOrder.getDiscount());
        Assert.assertEquals(expectedOrder.getPayment(), actualOrder.getPayment(), 0.00f);	
        
        Order nullOrder = dao.getOrderByUserAndFilmId(expectedOrder.getUserId(), expectedOrder.getFilmId());
        Assert.assertNull(nullOrder);
	}
	
	/**
	 * Gets orders by user ID in two different ways and compares results which must be equal.
	 * 
	 * @throws DAOException
	 */
	@Test
	public void getOrdersByUserId() throws DAOException {
		DAOFactory daoFactory = DAOFactory.getDAOFactory(MYSQL);
		IOrderDAO dao = daoFactory.getOrderDAO();
		
		Set<Order> userOrders1 = dao.getOrdersByUserId(1);
		Set<Order> userOrders2 = new LinkedHashSet<Order>();
		for (Order o : dao.getAllOrders()) {
			if (o.getUserId() == 1) {
				userOrders2.add(o);
			}
		}
		
		Assert.assertEquals(userOrders1, userOrders2);	
	}
	
	/**
	 * Gets orders by film ID in two different ways and compares results which must be equal.
	 * 
	 * @throws DAOException
	 */
	@Test
	public void getOrdersByFilmId() throws DAOException {
		DAOFactory daoFactory = DAOFactory.getDAOFactory(MYSQL);
		IOrderDAO dao = daoFactory.getOrderDAO();
		
		Set<Order> filmOrders1 = dao.getOrdersByFilmId(1);
		Set<Order> filmOrders2 = new LinkedHashSet<Order>();
		for (Order o : dao.getAllOrders()) {
			if (o.getFilmId() == 1) {
				filmOrders2.add(o);
			}
		}
		
		Assert.assertEquals(filmOrders1, filmOrders2);	
	}
}