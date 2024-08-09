
-- criando a tabela usuarios
CREATE TABLE usuarios(
    id INT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL,
    sobrenome VARCHAR(150) NOT NULL,
    criado_em DATETIME NOT NULL DEFAULT NOW(),
    atualizado_em DATETIME NOT NULL DEFAULT NOW() ON UPDATE NOW(),
    e-mail VARCHAR(255) NOT NULL UNIQUE KEY,
    salario DECIMAL(15, 2),
    hash_senha VARCHAR(255) NOT NULL UNIQUE key
)

-- criação da tabela papeis
CREATE TABLE papeis(
    id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL
)


-- criação da tabela de relacionamento usuarios_papeis
CREATE TABLE usuarios_papeis(
    id_usuario INT UNSIGNED NOT NULL,
    id_papel INT UNSIGNED NOT NULL,
    criado_em DATETIME NOT NULL DEFAULT NOW(),
    atualizado_em DATETIME NOT NULL DEFAULT NOW() ON UPDATE NOW(),
    PRIMARY key(id_usuario, id_papel),
    FOREIGN KEY(id_usuario) REFERENCES usuarios(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(id_papel) REFERENCES papeis(id) ON DELETE CASCADE ON UPDATE CASCADE
);


-- criação da tabela perfis
CREATE TABLE perfis(
    id INT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
    bio TEXT,
    descricao TEXT,
    id_usuario INT UNSIGNED NOT NULL UNIQUE KEY,
    FOREIGN KEY(id_usuario) REFERENCES usuarios(id) ON DELETE CASCADE ON UPDATE CASCADE
);

