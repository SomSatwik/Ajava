import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.Scanner;

public class HotelManagementApp {
    private HotelDatabaseManager dbManager;
    private Scanner scanner;

    public HotelManagementApp() {
        this.dbManager = new HotelDatabaseManager();
        this.scanner = new Scanner(System.in);
    }

    public void start() {
        System.out.println("╔════════════════════════════════════════════════════════════╗");
        System.out.println("║        WELCOME TO HOTEL MANAGEMENT SYSTEM                   ║");
        System.out.println("╚════════════════════════════════════════════════════════════╝\n");

        // Test database connection
        dbManager.testConnection();
        System.out.println();

        boolean running = true;
        while (running) {
            displayMainMenu();
            int choice = getIntInput();
            switch (choice) {
                case 1:
                    guestMenu();
                    break;
                case 2:
                    roomMenu();
                    break;
                case 3:
                    bookingMenu();
                    break;
                case 4:
                    viewAllBookings();
                    break;
                case 5:
                    System.out.println("\n✓ Thank you for using Hotel Management System. Goodbye!");
                    running = false;
                    break;
                default:
                    System.out.println("✗ Invalid option. Please try again.");
            }
            System.out.println();
        }
        scanner.close();
    }

    private void displayMainMenu() {
        System.out.println("╔════════════════════════════════════════════════════════════╗");
        System.out.println("║                      MAIN MENU                             ║");
        System.out.println("╠════════════════════════════════════════════════════════════╣");
        System.out.println("║ 1. Guest Management                                        ║");
        System.out.println("║ 2. Room Management                                         ║");
        System.out.println("║ 3. Booking Management                                      ║");
        System.out.println("║ 4. View All Bookings                                       ║");
        System.out.println("║ 5. Exit                                                    ║");
        System.out.println("╚════════════════════════════════════════════════════════════╝");
        System.out.print("Choose an option: ");
    }

    // ============== GUEST MENU ==============
    private void guestMenu() {
        boolean inGuestMenu = true;
        while (inGuestMenu) {
            System.out.println("\n╔════════════════════════════════════════════════════════════╗");
            System.out.println("║                   GUEST MANAGEMENT                         ║");
            System.out.println("╠════════════════════════════════════════════════════════════╣");
            System.out.println("║ 1. Add New Guest                                           ║");
            System.out.println("║ 2. View All Guests                                         ║");
            System.out.println("║ 3. Search Guest by ID                                      ║");
            System.out.println("║ 4. Back to Main Menu                                       ║");
            System.out.println("╚════════════════════════════════════════════════════════════╝");
            System.out.print("Choose an option: ");

            int choice = getIntInput();
            switch (choice) {
                case 1:
                    addNewGuest();
                    break;
                case 2:
                    viewAllGuests();
                    break;
                case 3:
                    searchGuestById();
                    break;
                case 4:
                    inGuestMenu = false;
                    break;
                default:
                    System.out.println("✗ Invalid option. Please try again.");
            }
        }
    }

    private void addNewGuest() {
        System.out.println("\n--- Add New Guest ---");
        System.out.print("Enter First Name: ");
        String firstName = scanner.nextLine().trim();
        System.out.print("Enter Last Name: ");
        String lastName = scanner.nextLine().trim();
        System.out.print("Enter Email: ");
        String email = scanner.nextLine().trim();
        System.out.print("Enter Phone: ");
        String phone = scanner.nextLine().trim();
        System.out.print("Enter Address: ");
        String address = scanner.nextLine().trim();

        Guest guest = new Guest(firstName, lastName, email, phone, address);
        if (dbManager.addGuest(guest)) {
            System.out.println("✓ Guest added successfully!");
        } else {
            System.out.println("✗ Failed to add guest.");
        }
    }

    private void viewAllGuests() {
        System.out.println("\n--- All Guests ---");
        List<Guest> guests = dbManager.getAllGuests();
        if (guests.isEmpty()) {
            System.out.println("No guests found.");
        } else {
            System.out.println(String.format("%-5s %-15s %-15s %-25s %-15s %-30s", 
                    "ID", "First", "Last", "Email", "Phone", "Address"));
            System.out.println("─".repeat(105));
            for (Guest guest : guests) {
                System.out.println(String.format("%-5d %-15s %-15s %-25s %-15s %-30s", 
                        guest.getGuestId(), guest.getFirstName(), guest.getLastName(), 
                        guest.getEmail(), guest.getPhone(), guest.getAddress()));
            }
        }
    }

    private void searchGuestById() {
        System.out.print("\nEnter Guest ID: ");
        int guestId = getIntInput();
        Guest guest = dbManager.getGuest(guestId);
        if (guest != null) {
            System.out.println("\n" + guest);
        } else {
            System.out.println("✗ Guest not found.");
        }
    }

    // ============== ROOM MENU ==============
    private void roomMenu() {
        boolean inRoomMenu = true;
        while (inRoomMenu) {
            System.out.println("\n╔════════════════════════════════════════════════════════════╗");
            System.out.println("║                   ROOM MANAGEMENT                          ║");
            System.out.println("╠════════════════════════════════════════════════════════════╣");
            System.out.println("║ 1. View All Rooms                                          ║");
            System.out.println("║ 2. View Available Rooms                                    ║");
            System.out.println("║ 3. Search Room by ID                                       ║");
            System.out.println("║ 4. Update Room Status                                      ║");
            System.out.println("║ 5. Back to Main Menu                                       ║");
            System.out.println("╚════════════════════════════════════════════════════════════╝");
            System.out.print("Choose an option: ");

            int choice = getIntInput();
            switch (choice) {
                case 1:
                    viewAllRooms();
                    break;
                case 2:
                    viewAvailableRooms();
                    break;
                case 3:
                    searchRoomById();
                    break;
                case 4:
                    updateRoomStatus();
                    break;
                case 5:
                    inRoomMenu = false;
                    break;
                default:
                    System.out.println("✗ Invalid option. Please try again.");
            }
        }
    }

    private void viewAllRooms() {
        System.out.println("\n--- All Rooms ---");
        List<Room> rooms = dbManager.getAllRooms();
        if (rooms.isEmpty()) {
            System.out.println("No rooms found.");
        } else {
            System.out.println(String.format("%-4s %-10s %-12s %-8s %-10s %-12s", 
                    "ID", "Number", "Type", "Cap", "Price/Nt", "Status"));
            System.out.println("─".repeat(60));
            for (Room room : rooms) {
                System.out.println(String.format("%-4d %-10s %-12s %-8d $%-9.2f %-12s", 
                        room.getRoomId(), room.getRoomNumber(), room.getRoomType(), 
                        room.getCapacity(), room.getPricePerNight(), room.getStatus()));
            }
        }
    }

    private void viewAvailableRooms() {
        System.out.println("\n--- Available Rooms ---");
        List<Room> rooms = dbManager.getAvailableRooms();
        if (rooms.isEmpty()) {
            System.out.println("No available rooms.");
        } else {
            System.out.println(String.format("%-4s %-10s %-12s %-8s %-10s", 
                    "ID", "Number", "Type", "Cap", "Price/Nt"));
            System.out.println("─".repeat(48));
            for (Room room : rooms) {
                System.out.println(String.format("%-4d %-10s %-12s %-8d $%-9.2f", 
                        room.getRoomId(), room.getRoomNumber(), room.getRoomType(), 
                        room.getCapacity(), room.getPricePerNight()));
            }
        }
    }

    private void searchRoomById() {
        System.out.print("\nEnter Room ID: ");
        int roomId = getIntInput();
        Room room = dbManager.getRoom(roomId);
        if (room != null) {
            System.out.println("\n" + room);
        } else {
            System.out.println("✗ Room not found.");
        }
    }

    private void updateRoomStatus() {
        System.out.print("\nEnter Room ID: ");
        int roomId = getIntInput();
        System.out.print("Enter new status (available/occupied/maintenance): ");
        String status = scanner.nextLine().trim().toLowerCase();
        
        if (status.equals("available") || status.equals("occupied") || status.equals("maintenance")) {
            if (dbManager.updateRoomStatus(roomId, status)) {
                System.out.println("✓ Room status updated successfully!");
            } else {
                System.out.println("✗ Failed to update room status.");
            }
        } else {
            System.out.println("✗ Invalid status. Please use: available, occupied, or maintenance");
        }
    }

    // ============== BOOKING MENU ==============
    private void bookingMenu() {
        boolean inBookingMenu = true;
        while (inBookingMenu) {
            System.out.println("\n╔════════════════════════════════════════════════════════════╗");
            System.out.println("║                  BOOKING MANAGEMENT                        ║");
            System.out.println("╠════════════════════════════════════════════════════════════╣");
            System.out.println("║ 1. Create New Booking                                      ║");
            System.out.println("║ 2. View Guest Bookings                                     ║");
            System.out.println("║ 3. Cancel Booking                                          ║");
            System.out.println("║ 4. Back to Main Menu                                       ║");
            System.out.println("╚════════════════════════════════════════════════════════════╝");
            System.out.print("Choose an option: ");

            int choice = getIntInput();
            switch (choice) {
                case 1:
                    createNewBooking();
                    break;
                case 2:
                    viewGuestBookings();
                    break;
                case 3:
                    cancelBooking();
                    break;
                case 4:
                    inBookingMenu = false;
                    break;
                default:
                    System.out.println("✗ Invalid option. Please try again.");
            }
        }
    }

    private void createNewBooking() {
        System.out.println("\n--- Create New Booking ---");
        
        // Get guest info
        System.out.print("Enter Guest ID: ");
        int guestId = getIntInput();
        Guest guest = dbManager.getGuest(guestId);
        if (guest == null) {
            System.out.println("✗ Guest not found.");
            return;
        }
        System.out.println("✓ Guest: " + guest.getFirstName() + " " + guest.getLastName());

        // View available rooms
        System.out.println("\nAvailable Rooms:");
        List<Room> availableRooms = dbManager.getAvailableRooms();
        if (availableRooms.isEmpty()) {
            System.out.println("✗ No available rooms.");
            return;
        }
        for (Room room : availableRooms) {
            System.out.println(String.format("ID: %d | Room %s | %s | Capacity: %d | Price: $%.2f/night", 
                    room.getRoomId(), room.getRoomNumber(), room.getRoomType(), 
                    room.getCapacity(), room.getPricePerNight()));
        }

        // Get room selection
        System.out.print("\nEnter Room ID: ");
        int roomId = getIntInput();
        Room room = dbManager.getRoom(roomId);
        if (room == null || !room.getStatus().equals("available")) {
            System.out.println("✗ Invalid or unavailable room.");
            return;
        }

        // Get dates
        System.out.print("Enter Check-in Date (YYYY-MM-DD): ");
        LocalDate checkInDate = LocalDate.parse(scanner.nextLine().trim());
        System.out.print("Enter Check-out Date (YYYY-MM-DD): ");
        LocalDate checkOutDate = LocalDate.parse(scanner.nextLine().trim());

        // Validate dates
        if (checkInDate.isAfter(checkOutDate) || checkInDate.isBefore(LocalDate.now())) {
            System.out.println("✗ Invalid dates.");
            return;
        }

        // Get number of guests
        System.out.print("Enter Number of Guests: ");
        int numberOfGuests = getIntInput();
        if (numberOfGuests > room.getCapacity()) {
            System.out.println("✗ Number of guests exceeds room capacity.");
            return;
        }

        // Calculate total price
        long nights = ChronoUnit.DAYS.between(checkInDate, checkOutDate);
        double totalPrice = nights * room.getPricePerNight();

        // Create booking
        Booking booking = new Booking(guestId, roomId, checkInDate, checkOutDate, numberOfGuests, totalPrice);
        if (dbManager.addBooking(booking)) {
            System.out.println("\n✓ Booking created successfully!");
            System.out.println(String.format("Booking Details: %d nights × $%.2f = $%.2f", 
                    nights, room.getPricePerNight(), totalPrice));
            // Update room status
            dbManager.updateRoomStatus(roomId, "occupied");
        } else {
            System.out.println("✗ Failed to create booking.");
        }
    }

    private void viewGuestBookings() {
        System.out.print("\nEnter Guest ID: ");
        int guestId = getIntInput();
        List<Booking> bookings = dbManager.getBookingsByGuest(guestId);
        if (bookings.isEmpty()) {
            System.out.println("No bookings found for this guest.");
        } else {
            System.out.println("\n--- Bookings for Guest ID: " + guestId + " ---");
            System.out.println(String.format("%-8s %-8s %-12s %-12s %-10s %-12s %-12s", 
                    "Booking", "Room", "Check-In", "Check-Out", "Guests", "Status", "Total"));
            System.out.println("─".repeat(85));
            for (Booking booking : bookings) {
                System.out.println(String.format("%-8d %-8d %-12s %-12s %-10d %-12s $%-11.2f", 
                        booking.getBookingId(), booking.getRoomId(), 
                        booking.getCheckInDate(), booking.getCheckOutDate(), 
                        booking.getNumberOfGuests(), booking.getBookingStatus(), 
                        booking.getTotalPrice()));
            }
        }
    }

    private void cancelBooking() {
        System.out.print("\nEnter Booking ID to cancel: ");
        int bookingId = getIntInput();
        if (dbManager.cancelBooking(bookingId)) {
            System.out.println("✓ Booking cancelled successfully!");
        } else {
            System.out.println("✗ Failed to cancel booking.");
        }
    }

    private void viewAllBookings() {
        System.out.println("\n--- All Bookings ---");
        List<Booking> bookings = dbManager.getAllBookings();
        if (bookings.isEmpty()) {
            System.out.println("No bookings found.");
        } else {
            System.out.println(String.format("%-8s %-8s %-8s %-12s %-12s %-10s %-12s %-12s", 
                    "Booking", "Guest", "Room", "Check-In", "Check-Out", "Guests", "Status", "Total"));
            System.out.println("─".repeat(100));
            for (Booking booking : bookings) {
                System.out.println(String.format("%-8d %-8d %-8d %-12s %-12s %-10d %-12s $%-11.2f", 
                        booking.getBookingId(), booking.getGuestId(), booking.getRoomId(), 
                        booking.getCheckInDate(), booking.getCheckOutDate(), 
                        booking.getNumberOfGuests(), booking.getBookingStatus(), 
                        booking.getTotalPrice()));
            }
        }
    }

    // Helper method to get integer input
    private int getIntInput() {
        try {
            return Integer.parseInt(scanner.nextLine().trim());
        } catch (NumberFormatException e) {
            return -1;
        }
    }

    public static void main(String[] args) {
        HotelManagementApp app = new HotelManagementApp();
        app.start();
    }
}
