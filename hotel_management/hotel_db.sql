-- Hotel Management System Database Schema

CREATE DATABASE IF NOT EXISTS hotel_management;
USE hotel_management;

-- Rooms Table
CREATE TABLE IF NOT EXISTS rooms (
    room_id INT PRIMARY KEY AUTO_INCREMENT,
    room_number VARCHAR(10) UNIQUE NOT NULL,
    room_type VARCHAR(50) NOT NULL,
    capacity INT NOT NULL,
    price_per_night DECIMAL(10, 2) NOT NULL,
    status VARCHAR(20) DEFAULT 'available'
);

-- Guests Table
CREATE TABLE IF NOT EXISTS guests (
    guest_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(15) NOT NULL,
    address VARCHAR(255)
);

-- Bookings Table
CREATE TABLE IF NOT EXISTS bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    guest_id INT NOT NULL,
    room_id INT NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    number_of_guests INT NOT NULL,
    booking_status VARCHAR(20) DEFAULT 'confirmed',
    total_price DECIMAL(10, 2),
    FOREIGN KEY (guest_id) REFERENCES guests(guest_id),
    FOREIGN KEY (room_id) REFERENCES rooms(room_id)
);

-- Insert Sample Rooms
INSERT INTO rooms (room_number, room_type, capacity, price_per_night, status) VALUES
('101', 'Single', 1, 50.00, 'available'),
('102', 'Double', 2, 80.00, 'available'),
('103', 'Suite', 4, 150.00, 'available'),
('104', 'Double', 2, 80.00, 'available'),
('105', 'Single', 1, 50.00, 'available'),
('106', 'Suite', 4, 150.00, 'available');

-- Insert Sample Guests
INSERT INTO guests (first_name, last_name, email, phone, address) VALUES
('John', 'Doe', 'john@email.com', '555-1234', '123 Main St'),
('Jane', 'Smith', 'jane@email.com', '555-5678', '456 Oak Ave'),
('Aniket', 'Kumar', 'aniket@email.com', '9876543210', '789 Pine Rd');
