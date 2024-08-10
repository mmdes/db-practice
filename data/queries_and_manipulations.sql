/*  Consultas e manipulações dos dados  */ 

-- Inserindo 5 usuários
INSERT INTO usuarios (nome, sobrenome, email, salario, hash_senha)
VALUES
	('Douglas', 'Macedo', 'douglas@email.com', 12000.78, '!@@#1213'),
	('João', 'da Silva', 'joaodasilva@email.com', 9872.12,'3$234543'),
	('Maria', 'de Souza', 'maria@email.com', 11654.23, '3%45&&%%'),
	('Junior', 'Messias', 'junior@email.com', 3000.50, '*6745%%$'),
	('Giovana', 'Gonçalves', 'giovana@email.com', 16000.00, '&*%$ee2e');


-- Inserindo 5 perfis para os usuários inseridos
INSERT INTO perfis(bio, descricao, id_usuario)	
VALUES
	('Uma bio do Douglas', 'Uma descrição de Douglas', (SELECT id FROM usuarios WHERE email = 'douglas@email.com')),
	('Uma bio do João', 'Uma descrição de João', (SELECT id FROM usuarios WHERE email = 'joaodasilva@email.com')),
	('Uma bio da Maria', 'Uma descrição da Maria', (SELECT id FROM usuarios WHERE email = 'maria@email.com')),
	('Uma bio do Junior', 'Uma descrição de Junior', (SELECT id FROM usuarios WHERE email = 'junior@email.com')),
	('Uma bio da Giovana', 'Uma descrição de Giovana', (SELECT id FROM usuarios WHERE email = 'giovana@email.com'));
-- Obs.: há melhores práticas para fazer isso, mas é apenas um teste com insert into com select


-- Inserindo permissões (papeis) para os usuários inseridos
INSERT INTO usuarios_papeis (id_usuario, id_papel)
VALUES
	(
		(SELECT id FROM usuarios WHERE email = 'douglas@email.com'), 
		(SELECT id FROM papeis WHERE nome = 'DELETE')
		
	),
	(
		(SELECT id FROM usuarios WHERE email = 'joaodasilva@email.com'), 
		(SELECT id FROM papeis WHERE nome = 'PUT')
	
	),
	(
		(SELECT id FROM usuarios WHERE email = 'maria@email.com'), 
		(SELECT id FROM papeis WHERE nome = 'GET')
	
	),
	(
		(SELECT id FROM usuarios WHERE email = 'junior@email.com'), 
		(SELECT id FROM papeis WHERE nome = 'POST')
	
	),
	(
		(SELECT id FROM usuarios WHERE email = 'giovana@email.com'), 
		(SELECT id FROM papeis WHERE nome = 'ADMIN')
	
	);


-- Selecionando os últimos 5 usuários por ordem decrescente
SELECT * 
FROM usuarios 
ORDER BY id DESC 
LIMIT 5;


-- Atualizando o último usuário inserido
SET @id = (SELECT id FROM usuarios ORDER BY id DESC LIMIT 1);
UPDATE usuarios 
SET 
    nome = 'Elis',
    sobrenome = 'Regina',
    email = 'elisregina@email.com'
WHERE id = @id;


-- Removendo uma permissão de algum usuário
DELETE FROM usuarios_papeis
WHERE 
    id_usuario = (SELECT id FROM usuarios WHERE email = 'elisregina@email.com') 
    AND id_papel = (SELECT id FROM papeis WHERE nome = 'ADMIN');

-- Removendo um usuário que tem a permissão "PUT"  
SET @id = (
    SELECT u.id 
    FROM usuarios u 
    INNER JOIN usuarios_papeis up ON u.id = up.id_usuario 
    INNER JOIN papeis p ON up.id_papel = p.id 
    WHERE p.nome = 'PUT'
    ORDER BY RAND()
    LIMIT 1
);
DELETE FROM usuarios 
WHERE id = @id;


-- Selecionando usuários com perfis e permissões (obrigatório)
SELECT u.id AS uid, u.nome, p2.nome AS papel, p.bio FROM usuarios u 
INNER JOIN perfis p ON u.id = p.id_usuario 
INNER JOIN usuarios_papeis up ON u.id = up.id_usuario 
INNER JOIN papeis p2 ON up.id_papel = p2.id 


-- Selecionionando usuários com perfis e permissões (opcional)
SELECT u.id AS uid, u.nome, p2.nome AS papel, p.bio FROM usuarios u 
LEFT JOIN perfis p ON u.id = p.id_usuario 
LEFT JOIN usuarios_papeis up ON u.id = up.id_usuario 
LEFT JOIN papeis p2 ON up.id_papel = p2.id 


-- Selecionando usuários com perfis e permissões ordenando por salário
SELECT u.id AS uid, u.nome, p2.nome AS papel, p.bio, u.salario FROM usuarios u 
INNER JOIN perfis p ON u.id = p.id_usuario 
INNER JOIN usuarios_papeis up ON u.id = up.id_usuario 
INNER JOIN papeis p2 ON up.id_papel = p2.id 
ORDER BY u.salario DESC 
