package by.epam.naumovich.film_ordering.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashSet;
import java.util.Set;

import by.epam.naumovich.film_ordering.bean.Review;
import by.epam.naumovich.film_ordering.dao.IReviewDAO;
import by.epam.naumovich.film_ordering.dao.exception.DAOException;
import by.epam.naumovich.film_ordering.dao.util.ExceptionMessages;
import by.epam.naumovich.task82.dao.pool.MySQLConnectionPool;
import by.epam.naumovich.task82.dao.pool.exception.ConnectionPoolException;

/**
 * IReviewDAO interface implementation that works with MySQL database
 * 
 * @author Dmitry Naumovich
 * @version 1.0
 */
public class MySQLReviewDAO implements IReviewDAO {

	public static final String INSERT_NEW_REVIEW = "INSERT INTO Reviews (r_author, r_film, r_date, r_time, r_type, r_mark, r_text) VALUES (?, ?, ?, ?, ?, ?, ?)";
	public static final String DELETE_REVIEW = "DELETE FROM Reviews WHERE r_author = ? and r_film = ?";
	public static final String SELECT_ALL_REVIEWS = "SELECT * FROM Reviews";
	public static final String SELECT_REVIEWS_BY_USER_ID = "SELECT * FROM Reviews WHERE r_author = ?";
	public static final String SELECT_REVIEWS_BY_FILM_ID = "SELECT * FROM Reviews WHERE r_film = ?";
	public static final String SELECT_REVIEW_BY_FILM_AND_USER_ID = "SELECT * FROM Reviews WHERE r_author = ? AND r_film = ?";
	public static final String UPDATE_FILM_RATING = "UPDATE Films SET f_rating = (SELECT AVG(r_mark) FROM Reviews WHERE r_film = ?) WHERE Films.f_id = ?";
	
	/**
	 * Singleton MySQLReviewDAO instance
	 */
	private static final MySQLReviewDAO instance = new MySQLReviewDAO();
	
	/**
	 * Static method that returns singleton MySQLReviewDAO instance
	 * @return MySQLReviewDAO object
	 */
	public static MySQLReviewDAO getInstance() {
		return instance;
	}

	@Override
	public void addReview(Review review) throws DAOException {
		MySQLConnectionPool pool = null;
		Connection con = null;
		PreparedStatement st = null;
		PreparedStatement stForRatingUpdate = null;
		try {
			pool = MySQLConnectionPool.getInstance();
			con = pool.getConnection();
			st = con.prepareStatement(INSERT_NEW_REVIEW);
			st.setInt(1, review.getAuthor());
			st.setInt(2, review.getFilmId());
			st.setDate(3, review.getDate());
			st.setTime(4, review.getTime());
			st.setString(5, review.getType());
			st.setInt(6, review.getMark());
			st.setString(7, review.getText());
			st.executeUpdate();
			
			stForRatingUpdate = con.prepareStatement(UPDATE_FILM_RATING);
			stForRatingUpdate.setInt(1, review.getFilmId());
			stForRatingUpdate.setInt(2, review.getFilmId());
			stForRatingUpdate.executeUpdate();
			
		} catch (SQLException e) {
			throw new DAOException(ExceptionMessages.SQL_INSERT_FAILURE, e);
		} catch (ConnectionPoolException e) {
			throw new DAOException(ExceptionMessages.CONNECTION_NOT_TAKEN, e);
		} finally {
			try {
				if (st != null) { st.close(); }
			} catch (SQLException e) {
				throw new DAOException(ExceptionMessages.PREP_STATEMENT_NOT_CLOSED, e);
			} finally {
				if (con != null) { pool.closeConnection(con); }
			}
		}
	}

	@Override
	public void deleteReview(int userID, int filmID) throws DAOException {
		MySQLConnectionPool pool = null;
		Connection con = null;
		PreparedStatement st = null;
		PreparedStatement stForRatingUpdate = null;
		try {
			pool = MySQLConnectionPool.getInstance();
			con = pool.getConnection();
			st = con.prepareStatement(DELETE_REVIEW);
			st.setInt(1, userID);
			st.setInt(2, filmID);
			st.executeUpdate();
			
			stForRatingUpdate = con.prepareStatement(UPDATE_FILM_RATING);
			stForRatingUpdate.setInt(1, filmID);
			stForRatingUpdate.setInt(2, filmID);
			stForRatingUpdate.executeUpdate();
			
		} catch (SQLException e) {
			throw new DAOException(ExceptionMessages.SQL_DELETE_FAILURE, e);
		} catch (ConnectionPoolException e) {
			throw new DAOException(ExceptionMessages.CONNECTION_NOT_TAKEN, e);
		} finally {
			try {
				if (st != null) { st.close(); }
			} catch (SQLException e) {
				throw new DAOException(ExceptionMessages.PREP_STATEMENT_NOT_CLOSED, e);
			} finally {
				if (con != null) { pool.closeConnection(con); }
			}
		}
	}
	
	@Override
	public Set<Review> getAllReviews() throws DAOException {
		Set<Review> reviewSet = new LinkedHashSet<Review>();
		MySQLConnectionPool pool = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			pool = MySQLConnectionPool.getInstance();
			con = pool.getConnection();
			st = con.prepareStatement(SELECT_ALL_REVIEWS);
			rs = st.executeQuery();
			
			while (rs.next()) {
				Review review = new Review();
				review.setAuthor(rs.getInt(1));
				review.setFilmId(rs.getInt(2));
				review.setDate(rs.getDate(3));
				review.setTime(rs.getTime(4));
				review.setType(rs.getString(5));
				review.setMark(rs.getInt(6));
				review.setText(rs.getString(7));
				
				reviewSet.add(review);
			}
			
		} catch (SQLException e) {
			throw new DAOException(ExceptionMessages.SQL_SELECT_FAILURE, e);
		} catch (ConnectionPoolException e) {
			throw new DAOException(ExceptionMessages.CONNECTION_NOT_TAKEN, e);
		} finally {
			try {
				if (rs != null) { rs.close(); }
				if (st != null) { st.close(); }
			} catch (SQLException e) {
				throw new DAOException(ExceptionMessages.RS_OR_STATEMENT_NOT_CLOSED);
			} finally {
				if (con != null) { pool.closeConnection(con); }
			}
		}
		return reviewSet;
	}

	@Override
	public Set<Review> getReviewsByUserId(int id) throws DAOException {
		Set<Review> reviewSet = new LinkedHashSet<Review>();
		MySQLConnectionPool pool = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			pool = MySQLConnectionPool.getInstance();
			con = pool.getConnection();
			st = con.prepareStatement(SELECT_REVIEWS_BY_USER_ID);
			st.setInt(1, id);
			rs = st.executeQuery();
			
			while (rs.next()) {
				Review review = new Review();
				review.setAuthor(rs.getInt(1));
				review.setFilmId(rs.getInt(2));
				review.setDate(rs.getDate(3));
				review.setTime(rs.getTime(4));
				review.setType(rs.getString(5));
				review.setMark(rs.getInt(6));
				review.setText(rs.getString(7));
	
				reviewSet.add(review);
			}
			
		} catch (SQLException e) {
			throw new DAOException(ExceptionMessages.SQL_SELECT_FAILURE, e);
		} catch (ConnectionPoolException e) {
			throw new DAOException(ExceptionMessages.CONNECTION_NOT_TAKEN, e);
		} finally {
			try {
				if (rs != null) { rs.close(); }
				if (st != null) { st.close(); }
			} catch (SQLException e) {
				throw new DAOException(ExceptionMessages.RS_OR_STATEMENT_NOT_CLOSED);
			} finally {
				if (con != null) { pool.closeConnection(con); }
			}
		}
		return reviewSet;
	}

	@Override
	public Set<Review> getReviewsByFilmId(int id) throws DAOException {
		Set<Review> reviewSet = new LinkedHashSet<Review>();
		MySQLConnectionPool pool = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			pool = MySQLConnectionPool.getInstance();
			con = pool.getConnection();
			st = con.prepareStatement(SELECT_REVIEWS_BY_FILM_ID);
			st.setInt(1, id);
			rs = st.executeQuery();
			
			while (rs.next()) {
				Review review = new Review();
				review.setAuthor(rs.getInt(1));
				review.setFilmId(rs.getInt(2));
				review.setDate(rs.getDate(3));
				review.setTime(rs.getTime(4));
				review.setType(rs.getString(5));
				review.setMark(rs.getInt(6));
				review.setText(rs.getString(7));
	
				reviewSet.add(review);
			}
			
		} catch (SQLException e) {
			throw new DAOException(ExceptionMessages.SQL_SELECT_FAILURE, e);
		} catch (ConnectionPoolException e) {
			throw new DAOException(ExceptionMessages.CONNECTION_NOT_TAKEN, e);
		} finally {
			try {
				if (rs != null) { rs.close(); }
				if (st != null) { st.close(); }
			} catch (SQLException e) {
				throw new DAOException(ExceptionMessages.RS_OR_STATEMENT_NOT_CLOSED);
			} finally {
				if (con != null) { pool.closeConnection(con); }
			}
		}
		return reviewSet;
	}

	@Override
	public Review getReviewByUserAndFilmId(int userID, int filmID) throws DAOException {
		Review review = null;;
		MySQLConnectionPool pool = null;
		Connection con = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			pool = MySQLConnectionPool.getInstance();
			con = pool.getConnection();
			st = con.prepareStatement(SELECT_REVIEW_BY_FILM_AND_USER_ID);
			st.setInt(1, userID);
			st.setInt(2, filmID);
			rs = st.executeQuery();
			
			if (rs.next()) {
				review = new Review();
				review.setAuthor(rs.getInt(1));
				review.setFilmId(rs.getInt(2));
				review.setDate(rs.getDate(3));
				review.setTime(rs.getTime(4));
				review.setType(rs.getString(5));
				review.setMark(rs.getInt(6));
				review.setText(rs.getString(7));
			}
			
		} catch (SQLException e) {
			throw new DAOException(ExceptionMessages.SQL_SELECT_FAILURE, e);
		} catch (ConnectionPoolException e) {
			throw new DAOException(ExceptionMessages.CONNECTION_NOT_TAKEN, e);
		} finally {
			try {
				if (rs != null) { rs.close(); }
				if (st != null) { st.close(); }
			} catch (SQLException e) {
				throw new DAOException(ExceptionMessages.RS_OR_STATEMENT_NOT_CLOSED);
			} finally {
				if (con != null) { pool.closeConnection(con); }
			}
		}
		return review;
	}
	
}
