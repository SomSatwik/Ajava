package bankingsystem;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Users {
    private final Connection conn;

    public Users(Connection conn) {
        this.conn = conn;
    }

    public boolean userExists(String email) throws SQLException {
        String sql = "SELECT 1 FROM user WHERE email = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    public boolean register(String fullName, String email, String password) throws SQLException {
        if (userExists(email)) {
            return false; // User already exists
        }

        String sql = "INSERT INTO user (full_name, email, password) VALUES (?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, fullName);
            ps.setString(2, email);
            ps.setString(3, password); // In a real app, hash this!
            int rows = ps.executeUpdate();
            return rows > 0;
        }
    }

    public String getFullName(String email) throws SQLException {
        String sql = "SELECT full_name FROM user WHERE email = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("full_name");
                }
            }
        }
        return null;
    }

    public boolean login(String email, String password) throws SQLException {
        String sql = "SELECT password FROM user WHERE email = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String stored = rs.getString("password");
                    return stored != null && stored.equals(password);
                }
            }
        }
        return false;
    }
}
