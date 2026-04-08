USE senior_game_rental;

-- 1. Most used games
SELECT g.game_title, COUNT(bg.booking_id) AS times_booked
FROM games g
JOIN booking_games bg ON g.game_id = bg.game_id
GROUP BY g.game_id, g.game_title
ORDER BY times_booked DESC;

-- 2. Game genres enjoyed by seniors aged 75+
SELECT g.genre, COUNT(*) AS total_sessions
FROM seniors s
JOIN bookings b ON s.senior_id = b.senior_id
JOIN booking_games bg ON b.booking_id = bg.booking_id
JOIN games g ON bg.game_id = g.game_id
WHERE TIMESTAMPDIFF(YEAR, s.date_of_birth, CURDATE()) >= 75
GROUP BY g.genre
ORDER BY total_sessions DESC;

-- 3. Session frequency and mood improvement
SELECT s.senior_id, s.first_name, s.last_name,
       COUNT(b.booking_id) AS total_sessions,
       AVG(sf.mood_improvement_score) AS avg_mood_improvement
FROM seniors s
LEFT JOIN bookings b ON s.senior_id = b.senior_id
LEFT JOIN session_feedback sf ON b.booking_id = sf.booking_id
GROUP BY s.senior_id, s.first_name, s.last_name
ORDER BY total_sessions DESC;

-- 4. Peak booking days
SELECT DAYNAME(booking_date) AS booking_day, COUNT(*) AS total_bookings
FROM bookings
GROUP BY DAYNAME(booking_date)
ORDER BY total_bookings DESC;

-- 5. Revenue per month
SELECT DATE_FORMAT(payment_date, '%Y-%m') AS month, SUM(amount) AS total_revenue
FROM payments
WHERE payment_status = 'paid'
GROUP BY DATE_FORMAT(payment_date, '%Y-%m')
ORDER BY month;

-- 6. Feedback and satisfaction
SELECT s.first_name, s.last_name, sf.rating, sf.mood_improvement_score, sf.comments
FROM session_feedback sf
JOIN seniors s ON sf.senior_id = s.senior_id
ORDER BY sf.feedback_date DESC;

-- 7. Cognitive tracking
SELECT s.first_name, s.last_name, c.assessment_date, c.memory_score, c.attention_score,
       c.problem_solving_score, c.engagement_score
FROM cognitive_scores c
JOIN seniors s ON c.senior_id = s.senior_id
ORDER BY c.assessment_date DESC;