USE senior_game_rental;

INSERT INTO users (username, password_hash, role) VALUES
('admin1', 'hashed_admin_pass', 'admin'),
('user1', 'hashed_user_pass', 'regular'),
('user2', 'hashed_user_pass', 'regular');

INSERT INTO students (first_name, last_name, phone, email, user_id) VALUES
('Brian', 'Smith', '0712345678', 'brian@student.com', 2),
('Alice', 'Johnson', '0723456789', 'alice@student.com', 3);

INSERT INTO seniors (first_name, last_name, phone, email, address, date_of_birth, student_rep_id, emergency_contact_name, emergency_contact_phone, notes) VALUES
('John', 'Brown', '0700111222', 'john@example.com', 'Westfield', '1945-06-15', 1, 'Mary Brown', '0700999888', 'Enjoys puzzle games'),
('Grace', 'Taylor', '0700222333', 'grace@example.com', 'Central Town', '1948-03-20', 2, 'Peter Taylor', '0711222333', 'Prefers short gaming sessions');

INSERT INTO consoles (console_name, brand, platform, quantity_total, quantity_available, max_players, status, condition_notes) VALUES
('PlayStation 4', 'Sony', 'PS4', 3, 2, 4, 'available', 'Good condition'),
('Nintendo Switch', 'Nintendo', 'Switch', 2, 2, 4, 'available', 'Portable and senior-friendly');

INSERT INTO games (game_title, genre, platform, age_rating, quantity_total, quantity_available, status, condition_notes) VALUES
('Mario Kart 8', 'Racing', 'Switch', 'E', 3, 2, 'available', 'Popular for group play'),
('FIFA 23', 'Sports', 'PS4', 'E', 2, 1, 'available', 'Used for friendly competition'),
('Tetris Effect', 'Puzzle', 'PS4', 'E', 4, 4, 'available', 'Good for focus and memory');

INSERT INTO bookings (senior_id, console_id, booked_by_user_id, booking_date, due_date, return_date, number_of_players, status, notes) VALUES
(1, 1, 1, '2026-04-01', '2026-04-03', '2026-04-03', 2, 'returned', 'Weekend session'),
(2, 2, 1, '2026-04-02', '2026-04-04', NULL, 3, 'checked_out', 'Family-assisted session');

INSERT INTO booking_games (booking_id, game_id, quantity) VALUES
(1, 2, 1),
(1, 3, 1),
(2, 1, 1);

INSERT INTO payments (booking_id, amount, payment_date, payment_method, payment_status) VALUES
(1, 1500.00, '2026-04-01', 'mobile_money', 'paid'),
(2, 2000.00, '2026-04-02', 'cash', 'paid');

INSERT INTO session_feedback (booking_id, senior_id, rating, mood_improvement_score, comments, feedback_date) VALUES
(1, 1, 5, 8, 'Very enjoyable and engaging', '2026-04-03'),
(2, 2, 4, 7, 'Loved the social interaction', '2026-04-04');

INSERT INTO cognitive_scores (senior_id, assessment_date, memory_score, attention_score, problem_solving_score, engagement_score, notes) VALUES
(1, '2026-04-03', 78, 80, 75, 85, 'Steady progress'),
(2, '2026-04-04', 70, 74, 72, 81, 'Responds well to guided play');