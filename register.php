<?php
header('Content-Type: application/json');

$host = 'localhost';
$db   = 'f1144751_aidbridge2014';
$user = 'f1144751_aidbridge2014';
$pass = 'cena20142014';

$conn = new mysqli($host, $user, $pass, $db);
if ($conn->connect_error) {
    http_response_code(500);
    echo json_encode(['error' => 'Ошибка подключения к базе данных']);
    exit;
}

$username = $_POST['username'] ?? '';
$email = $_POST['email'] ?? '';
$password = $_POST['password'] ?? '';

if (!$username || !$email || !$password) {
    http_response_code(400);
    echo json_encode(['error' => 'Заполните все поля']);
    exit;
}

if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    http_response_code(400);
    echo json_encode(['error' => 'Некорректный email']);
    exit;
}

$passwordHash = password_hash($password, PASSWORD_DEFAULT);

$stmt = $conn->prepare("SELECT id FROM users WHERE email = ? OR username = ?");
$stmt->bind_param("ss", $email, $username);
$stmt->execute();
$stmt->store_result();

if ($stmt->num_rows > 0) {
    http_response_code(409);
    echo json_encode(['error' => 'Пользователь с таким email или именем уже существует']);
    exit;
}
$stmt->close();

$stmt = $conn->prepare("INSERT INTO users (username, email, password_hash) VALUES (?, ?, ?)");
$stmt->bind_param("sss", $username, $email, $passwordHash);

if ($stmt->execute()) {
    echo json_encode(['success' => 'Пользователь зарегистрирован']);
} else {
    http_response_code(500);
    echo json_encode(['error' => 'Ошибка сервера']);
}

$stmt->close();
$conn->close();
?>
