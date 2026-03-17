import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class HotelDatabaseManager {
    private String url = "jdbc:mysql://localhost:3306/hotel_management";
    private String user = "root";
    private String password = "root";

    // Initialize database connection
    public Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(url, user, password);
    }

    // GUEST OPERATIONS
    public boolean addGuest(Guest guest) {
        String query = "INSERT INTO guests (first_name, last_name, email, phone, address) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, guest.getFirstName());
            pstmt.setString(2, guest.getLastName());
            pstmt.setString(3, guest.getEmail());
            pstmt.setString(4, guest.getPhone());
            pstmt.setString(5, guest.getAddress());
            int rows = pstmt.executeUpdate();
            return rows > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Guest getGuest(int guestId) {
        String query = "SELECT * FROM guests WHERE guest_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, guestId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return new Guest(rs.getInt("guest_id"), rs.getString("first_name"), 
                                 rs.getString("last_name"), rs.getString("email"), 
                                 rs.getString("phone"), rs.getString("address"));
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Guest> getAllGuests() {
        List<Guest> guests = new ArrayList<>();
        String query = "SELECT * FROM guests";
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                Guest guest = new Guest(rs.getInt("guest_id"), rs.getString("first_name"), 
                                        rs.getString("last_name"), rs.getString("email"), 
                                        rs.getString("phone"), rs.getString("address"));
                guests.add(guest);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return guests;
    }

    // ROOM OPERATIONS
    public List<Room> getAvailableRooms() {
        List<Room> rooms = new ArrayList<>();
        String query = "SELECT * FROM rooms WHERE status = 'available'";
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                Room room = new Room(rs.getInt("room_id"), rs.getString("room_number"), 
                                    rs.getString("room_type"), rs.getInt("capacity"), 
                                    rs.getDouble("price_per_night"), rs.getString("status"));
                rooms.add(room);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return rooms;
    }

    public List<Room> getAllRooms() {
        List<Room> rooms = new ArrayList<>();
        String query = "SELECT * FROM rooms";
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                Room room = new Room(rs.getInt("room_id"), rs.getString("room_number"), 
                                    rs.getString("room_type"), rs.getInt("capacity"), 
                                    rs.getDouble("price_per_night"), rs.getString("status"));
                rooms.add(room);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return rooms;
    }

    public Room getRoom(int roomId) {
        String query = "SELECT * FROM rooms WHERE room_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, roomId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return new Room(rs.getInt("room_id"), rs.getString("room_number"), 
                               rs.getString("room_type"), rs.getInt("capacity"), 
                               rs.getDouble("price_per_night"), rs.getString("status"));
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateRoomStatus(int roomId, String status) {
        String query = "UPDATE rooms SET status = ? WHERE room_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, status);
            pstmt.setInt(2, roomId);
            int rows = pstmt.executeUpdate();
            return rows > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    // BOOKING OPERATIONS
    public boolean addBooking(Booking booking) {
        String query = "INSERT INTO bookings (guest_id, room_id, check_in_date, check_out_date, number_of_guests, total_price, booking_status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, booking.getGuestId());
            pstmt.setInt(2, booking.getRoomId());
            pstmt.setString(3, booking.getCheckInDate().toString());
            pstmt.setString(4, booking.getCheckOutDate().toString());
            pstmt.setInt(5, booking.getNumberOfGuests());
            pstmt.setDouble(6, booking.getTotalPrice());
            pstmt.setString(7, booking.getBookingStatus());
            int rows = pstmt.executeUpdate();
            return rows > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Booking> getBookingsByGuest(int guestId) {
        List<Booking> bookings = new ArrayList<>();
        String query = "SELECT * FROM bookings WHERE guest_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, guestId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Booking booking = new Booking(rs.getInt("booking_id"), rs.getInt("guest_id"), 
                                             rs.getInt("room_id"), 
                                             LocalDate.parse(rs.getString("check_in_date")), 
                                             LocalDate.parse(rs.getString("check_out_date")), 
                                             rs.getInt("number_of_guests"), 
                                             rs.getString("booking_status"), 
                                             rs.getDouble("total_price"));
                bookings.add(booking);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return bookings;
    }

    public List<Booking> getAllBookings() {
        List<Booking> bookings = new ArrayList<>();
        String query = "SELECT * FROM bookings";
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                Booking booking = new Booking(rs.getInt("booking_id"), rs.getInt("guest_id"), 
                                             rs.getInt("room_id"), 
                                             LocalDate.parse(rs.getString("check_in_date")), 
                                             LocalDate.parse(rs.getString("check_out_date")), 
                                             rs.getInt("number_of_guests"), 
                                             rs.getString("booking_status"), 
                                             rs.getDouble("total_price"));
                bookings.add(booking);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return bookings;
    }

    public boolean cancelBooking(int bookingId) {
        String query = "UPDATE bookings SET booking_status = 'cancelled' WHERE booking_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, bookingId);
            int rows = pstmt.executeUpdate();
            return rows > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    public void testConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = getConnection();
            if (conn != null) {
                System.out.println("✓ Database connection successful!");
                conn.close();
            }
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("✗ Database connection failed: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
