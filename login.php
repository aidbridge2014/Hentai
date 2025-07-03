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

$email = $_POST['email'] ?? '';
$password = $_POST['password'] ?? '';

if (!$email || !$password) {
    http_response_code(400);
    echo json_encode(['error' => 'Заполните все поля']);
    exit;
}

$stmt = $conn->prepare("SELECT id, username, password_hash FROM users WHERE email = ?");
$stmt->bind_param("s", $email);
$stmt->execute();
$stmt->store_result();

if ($stmt->num_rows === 0) {
    http_response_code(401);
    echo json_encode(['error' => 'Неверный email или пароль']);
    exit;
}

$stmt->bind_result($id, $username, $passwordHash);
$stmt->fetch();

if (!password_verify($password, $passwordHash)) {
    http_response_code(401);
    echo json_encode(['error' => 'Неверный email или пароль']);
    exit;
}

echo json_encode(['success' => 'Вход выполнен', 'username' => $username]);

$stmt->close();
$conn->close();
?>
