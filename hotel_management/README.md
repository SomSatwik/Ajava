# Hotel Management System

A comprehensive Java-based hotel management application with MySQL database integration using JDBC.

## Features

✓ **Guest Management** - Add and view guest information  
✓ **Room Management** - Manage room inventory, status, and availability  
✓ **Booking System** - Create, view, and cancel hotel bookings  
✓ **Price Calculation** - Automatic total price calculation based on nights stayed  
✓ **Database Integration** - Full JDBC connectivity with MySQL  

## Project Structure

```
e-hotel/
├── src/
│   ├── HotelManagementApp.java      (Main application with interactive menu)
│   ├── HotelDatabaseManager.java    (Database operations)
│   ├── Guest.java                  (Guest entity class)
│   ├── Room.java                   (Room entity class)
│   └── Booking.java                (Booking entity class)
├── lib/                            (MySQL JDBC driver)
├── hotel_db.sql                    (Database schema and sample data)
└── README.md                       (This file)
```

## Prerequisites

1. **Java Development Kit (JDK)** - Version 8 or higher
2. **MySQL Server** - Running and accessible
3. **MySQL JDBC Driver** - `mysql-connector-java-8.x.x.jar`

## Setup Instructions

### 1. Download MySQL JDBC Driver

Download the MySQL Connector/J from [MySQL Downloads](https://dev.mysql.com/downloads/connector/j/)

Extract and place `mysql-connector-java-8.x.x.jar` in the `lib/` folder.

### 2. Create Database

Run the SQL script to set up the database:

```bash
mysql -u root -p < hotel_db.sql
```

Or manually execute the queries in `hotel_db.sql` in your MySQL client.

### 3. Update Database Credentials (if needed)

Edit `src/HotelDatabaseManager.java` and update these lines if your credentials differ:

```java
private String url = "jdbc:mysql://localhost:3306/hotel_management";
private String user = "root";
private String password = "Aniket123";
```

### 4. Compile the Application

Open a terminal in the project root and compile:

```bash
javac -cp lib/mysql-connector-java-8.x.x.jar src/*.java -d src
```

### 5. Run the Application

```bash
java -cp lib/mysql-connector-java-8.x.x.jar:src HotelManagementApp
```

Or on Windows:

```bash
java -cp "lib/mysql-connector-java-8.x.x.jar;src" HotelManagementApp
```

## Usage

Once the application starts, you'll see an interactive menu:

### Main Menu Options

1. **Guest Management**
   - Add new guests
   - View all guests
   - Search guest by ID

2. **Room Management**
   - View all rooms
   - View available rooms
   - Search room by ID
   - Update room status (available/occupied/maintenance)

3. **Booking Management**
   - Create new booking (with automatic price calculation)
   - View guest bookings
   - Cancel bookings

4. **View All Bookings**
   - See all bookings across the hotel

## Database Schema

### Rooms Table
- `room_id` - Primary key
- `room_number` - Unique room number
- `room_type` - Type of room (Single, Double, Suite)
- `capacity` - Maximum guests
- `price_per_night` - Daily rate
- `status` - Available/Occupied/Maintenance

### Guests Table
- `guest_id` - Primary key
- `first_name` - Guest's first name
- `last_name` - Guest's last name
- `email` - Email address
- `phone` - Contact number
- `address` - Physical address

### Bookings Table
- `booking_id` - Primary key
- `guest_id` - Foreign key (guests)
- `room_id` - Foreign key (rooms)
- `check_in_date` - Check-in date
- `check_out_date` - Check-out date
- `number_of_guests` - Number of people
- `booking_status` - Confirmed/Cancelled
- `total_price` - Total booking cost

## Sample Data

The database includes:
- 6 sample rooms (Singles, Doubles, Suites)
- 3 sample guests
- Room types with varying capacities and prices

## Troubleshooting

**Connection Failed Error:**
- Ensure MySQL is running
- Check database credentials in `HotelDatabaseManager.java`
- Verify MySQL JDBC driver is in the `lib/` folder

**Compilation Error:**
- Ensure all `.java` files are in the `src/` folder
- Check that the JDBC driver jar name matches in the compile command

**Date Format Error:**
- When entering dates, use format: `YYYY-MM-DD` (e.g., `2025-02-15`)

## Example Workflow

1. **Add a Guest**
   - Main Menu → 1 (Guest Management) → 1 (Add New Guest)
   - Enter guest details when prompted

2. **Create a Booking**
   - Main Menu → 3 (Booking Management) → 1 (Create New Booking)
   - Select guest ID and available room
   - Enter check-in/check-out dates
   - System calculates total price automatically

3. **View Bookings**
   - Main Menu → 4 (View All Bookings) to see all reservations

## Notes

- Check-in dates cannot be in the past
- Check-out date must be after check-in date
- Number of guests cannot exceed room capacity
- Bookings automatically update room status to "occupied"
- Cancelled bookings are marked but not deleted from database

## Future Enhancements

- GUI interface using Swing or JavaFX
- Payment processing integration
- Email notifications for bookings
- Advanced reporting features
- Multi-user login system

---

**Version:** 1.0  
**Created:** January 2026  
**Database:** MySQL  
**Language:** Java 8+
