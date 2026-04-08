CREATE DATABASE IF NOT EXISTS senior_game_rental;
USE senior_game_rental;

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('admin', 'regular') NOT NULL DEFAULT 'regular',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    user_id INT UNIQUE,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

CREATE TABLE seniors (
    senior_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100),
    address VARCHAR(255),
    date_of_birth DATE,
    student_rep_id INT NOT NULL,
    emergency_contact_name VARCHAR(100),
    emergency_contact_phone VARCHAR(20),
    notes TEXT,
    FOREIGN KEY (student_rep_id) REFERENCES students(student_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

CREATE TABLE consoles (
    console_id INT AUTO_INCREMENT PRIMARY KEY,
    console_name VARCHAR(100) NOT NULL,
    brand VARCHAR(50),
    platform VARCHAR(50) NOT NULL,
    quantity_total INT NOT NULL DEFAULT 1,
    quantity_available INT NOT NULL DEFAULT 1,
    max_players INT DEFAULT 1,
    status ENUM('available', 'unavailable', 'maintenance') DEFAULT 'available',
    condition_notes TEXT
);

CREATE TABLE games (
    game_id INT AUTO_INCREMENT PRIMARY KEY,
    game_title VARCHAR(100) NOT NULL,
    genre VARCHAR(50),
    platform VARCHAR(50) NOT NULL,
    age_rating VARCHAR(20),
    quantity_total INT NOT NULL DEFAULT 1,
    quantity_available INT NOT NULL DEFAULT 1,
    status ENUM('available', 'booked', 'unavailable', 'maintenance') DEFAULT 'available',
    condition_notes TEXT
);

CREATE TABLE bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    senior_id INT NOT NULL,
    console_id INT NULL,
    booked_by_user_id INT NULL,
    booking_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE NULL,
    number_of_players INT DEFAULT 1,
    status ENUM('booked', 'checked_out', 'returned', 'cancelled') DEFAULT 'booked',
    notes TEXT,
    FOREIGN KEY (senior_id) REFERENCES seniors(senior_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (console_id) REFERENCES consoles(console_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    FOREIGN KEY (booked_by_user_id) REFERENCES users(user_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

CREATE TABLE booking_games (
    booking_id INT NOT NULL,
    game_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    PRIMARY KEY (booking_id, game_id),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (game_id) REFERENCES games(game_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);


CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_date DATE NOT NULL,
    payment_method ENUM('cash', 'mobile_money', 'card') NOT NULL,
    payment_status ENUM('pending', 'paid', 'failed') DEFAULT 'pending',
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE session_feedback (
    feedback_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    senior_id INT NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    mood_improvement_score INT CHECK (mood_improvement_score BETWEEN 1 AND 10),
    comments TEXT,
    feedback_date DATE NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (senior_id) REFERENCES seniors(senior_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE cognitive_scores (
    score_id INT AUTO_INCREMENT PRIMARY KEY,
    senior_id INT NOT NULL,
    assessment_date DATE NOT NULL,
    memory_score INT,
    attention_score INT,
    problem_solving_score INT,
    engagement_score INT,
    notes TEXT,
    FOREIGN KEY (senior_id) REFERENCES seniors(senior_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);