---- INDEX
--CREATE INDEX IX_Usuario_Cpf_usuario ON Usuario (Cpf_usuario);
	
--	GO

---- PROCEDURE para inserir atividades que podem ser desafios ou trilhas
--CREATE PROCEDURE dbo.InserirAtividadeDesafioOuTrilha
--    @descricao_atividade VARCHAR(100),
--    @Cod_assunto INTEGER,
--    @tipo_atividade CHAR(1) -- 'D' para Desafio, 'T' para Trilha
--AS
--BEGIN
--    DECLARE @Cod_atividade INTEGER;

--    -- Inserir a atividade
--    INSERT INTO Atividade (descricao_atividade, Cod_assunto)
--    VALUES (@descricao_atividade, @Cod_assunto);

--    -- Obter o c�digo da atividade rec�m-inserida
--    SET @Cod_atividade = SCOPE_IDENTITY();

--    -- Inserir na tabela correspondente (Desafio ou Trilha)
--    IF @tipo_atividade = 'D'
--    BEGIN
--        INSERT INTO Desafio (Cod_atividade, qtd_ponto)
--        VALUES (@Cod_atividade, 0); -- Defina a pontua��o inicial conforme necess�rio
--    END
--    ELSE IF @tipo_atividade = 'T'
--    BEGIN
--        INSERT INTO Trilha (Cod_atividade, percurso)
--        VALUES (@Cod_atividade, 'Percurso n�o definido'); -- Pode ser ajustado conforme necess�rio
--    END
--    ELSE
--    BEGIN
--        -- Se o tipo de atividade n�o for v�lido, pode-se adotar alguma a��o apropriada
--        THROW 50000, 'Tipo de atividade inv�lido. Use ''D'' para Desafio ou ''T'' para Trilha.', 1;
--        RETURN;
--    END;
--END;

--	GO
---- Declare e atribua valores �s vari�veis
--DECLARE @descricao_atividade VARCHAR(100) = 'Corrida contra a matem�tica';
--DECLARE @Cod_assunto INT = 1;
--DECLARE @tipo_atividade CHAR(1) = 'F';

---- Execute a procedure com as vari�veis
--EXEC dbo.InserirAtividadeDesafioOuTrilha
--    @descricao_atividade,
--    @Cod_assunto,
--    @tipo_atividade;

---- Declare e atribua valores �s vari�veis
--DECLARE @descricao_atividade VARCHAR(100) = 'Corrida contra a matem�tica';
--DECLARE @Cod_assunto INT = 1;
--DECLARE @tipo_atividade CHAR(1) = 'D';

---- Execute a procedure com as vari�veis
--EXEC dbo.InserirAtividadeDesafioOuTrilha
--    @descricao_atividade,
--    @Cod_assunto,
--    @tipo_atividade;

--CREATE TABLE Usuario (
--	Cpf_usuario CHAR(11) PRIMARY KEY,
--	curso VARCHAR(28) NOT NULL DEFAULT 'Indefinido',
--	telefone VARCHAR(13) NOT NULL,
--	email VARCHAR(80) UNIQUE NOT NULL,
--	nome VARCHAR(50) NOT NULL,
--	sexo CHAR(1) NOT NULL CHECK(sexo='M' OR sexo='F'),
--	data_nascimento DATE NOT NULL
--);
--	GO

--CREATE TABLE Loja (
--	Cod_produto INTEGER PRIMARY KEY IDENTITY(1000, 10),
--	preco MONEY NOT NULL,
--	estoque INT NOT NULL
--);

--	GO

--CREATE TABLE Assunto (
--	Cod_assunto INTEGER PRIMARY KEY,
--	disciplina VARCHAR(28) NOT NULL,
--	descricao_assunto VARCHAR(100) NOT NULL
--);

--	GO

--CREATE TABLE Material (
--	Cod_material INTEGER PRIMARY KEY,
--	descricao_material VARCHAR(100) NOT NULL,
--	Cod_assunto INTEGER NOT NULL,
--	FOREIGN KEY (Cod_assunto) REFERENCES Assunto(Cod_assunto)
--);


--	GO

--CREATE TABLE Atividade (
--	Cod_atividade INTEGER PRIMARY KEY,
--	descricao_atividade VARCHAR(100) NOT NULL,
--	Cod_assunto INTEGER NOT NULL,
--	FOREIGN KEY (Cod_assunto) REFERENCES Assunto(Cod_assunto)
--);

--	GO

--CREATE TABLE Desafio (
--	Cod_desafio INTEGER PRIMARY KEY,
--	qtd_ponto INT NOT NULL,
--	Cod_atividade INTEGER NOT NULL,
--	FOREIGN KEY (Cod_atividade) REFERENCES Atividade(Cod_atividade) ON DELETE CASCADE
--);

--	GO

--CREATE TABLE Trilha (
--	Cod_trilha INTEGER PRIMARY KEY,
--	percurso VARCHAR(50) NOT NULL,
--	Cod_atividade INTEGER NOT NULL
--	FOREIGN KEY (Cod_atividade) REFERENCES Atividade(Cod_atividade) ON DELETE CASCADE
--);

--	GO

--CREATE TABLE Professor (
--	Cpf_professor CHAR(11) PRIMARY KEY,
--	data_nascimento_professor DATE NOT NULL,
--	nome VARCHAR(50) NOT NULL,
--	sexo CHAR(1) NOT NULL CHECK (sexo='M' OR sexo='F'),
--	email VARCHAR(80) UNIQUE NOT NULL,
--	telefone VARCHAR(13) NOT NULL,
--	especializacao VARCHAR(28) NOT NULL 

--);

--	GO

--CREATE TABLE Mentoria (
--	Cod_mentoria INTEGER PRIMARY KEY,
--	horario TIME NOT NULL,
--	data DATE NOT NULL,
--	descricao_conteudo VARCHAR(80) NOT NULL,
--	Cpf_professor CHAR(11) NOT NULL,
--	Cod_assunto INTEGER NOT NULL,
--	FOREIGN KEY (Cpf_professor) REFERENCES Professor(Cpf_professor),
--	FOREIGN KEY (Cod_assunto) REFERENCES Assunto(Cod_assunto)
--);

--	GO

--CREATE TABLE usuariomentoria (
--	Cpf_usuario CHAR(11) NOT NULL,
--	Cod_mentoria INTEGER NOT NULL,
--	FOREIGN KEY (Cpf_usuario) REFERENCES Usuario(Cpf_usuario),
--	FOREIGN KEY (Cod_mentoria) REFERENCES Mentoria(Cod_mentoria),
--	PRIMARY KEY (Cpf_usuario, Cod_mentoria)
--);
--	GO

--CREATE TABLE atividadetexto (
--	Cod_atividade INTEGER NOT NULL,
--	Cpf_usuario CHAR(11) NOT NULL,
--	FOREIGN KEY (Cod_atividade) REFERENCES Atividade(Cod_atividade),
--	FOREIGN KEY (Cpf_usuario) REFERENCES Usuario(Cpf_usuario),
--	PRIMARY KEY (Cod_atividade, Cpf_usuario)
--);
--	GO

--CREATE TABLE lojamaterial (
--	Cod_produto INTEGER NOT NULL,
--	Cod_material INTEGER NOT NULL,
--	FOREIGN KEY (Cod_produto) REFERENCES Loja(Cod_produto),
--	FOREIGN KEY (Cod_material) REFERENCES Material(Cod_material),
--	PRIMARY KEY(Cod_produto, Cod_material)
--);
--	GO
--	-- Trigger para Usuario
--CREATE TRIGGER insercao_usuario
--ON Usuario
--AFTER INSERT
--AS
--BEGIN
--    SET NOCOUNT ON;
--    PRINT 'Um novo registro foi inserido em Usuario.';
--END;
--	GO
--CREATE TRIGGER update_usuario
--ON Usuario
--AFTER UPDATE
--AS
--BEGIN
--    SET NOCOUNT ON;
--    PRINT 'Um registro foi atualizado na tabela Usuario.';
--END;
--	GO
--CREATE TRIGGER delete_usuario
--ON Usuario
--AFTER DELETE
--AS
--BEGIN
--    SET NOCOUNT ON;
--    PRINT 'Um registro foi removido da tabela Usuario.';
--END;
--	GO
---- Trigger para Professor
--CREATE TRIGGER insercao_professor
--ON Professor
--AFTER INSERT
--AS
--BEGIN
--    SET NOCOUNT ON;
--    PRINT 'Um novo registro foi inserido em Professor.';
--END;
--	GO
--CREATE TRIGGER update_professor
--ON Professor
--AFTER UPDATE
--AS
--BEGIN
--    SET NOCOUNT ON;
--    PRINT 'Um registro foi atualizado na tabela Professor.';
--END;
--	GO
--CREATE TRIGGER delete_professor
--ON Professor
--AFTER DELETE
--AS
--BEGIN
--    SET NOCOUNT ON;
--    PRINT 'Um registro foi removido da tabela Professor.';
--END;
--	GO
---- Trigger para Atividade
--CREATE TRIGGER insercao_atividade
--ON Atividade
--AFTER INSERT
--AS
--BEGIN
--    SET NOCOUNT ON;
--    PRINT 'Um novo registro foi inserido em Atividade.';
--END;
--	GO
--CREATE TRIGGER update_atividade
--ON Atividade
--AFTER UPDATE
--AS
--BEGIN
--    SET NOCOUNT ON;
--    PRINT 'Um registro foi atualizado na tabela Atividade.';
--END;
--	GO
--CREATE TRIGGER delete_atividade
--ON Atividade
--AFTER DELETE
--AS
--BEGIN
--    SET NOCOUNT ON;
--    PRINT 'Um registro foi removido da tabela Atividade.';
--END;
--	GO
---- Trigger para Loja
--CREATE TRIGGER insercao_loja
--ON Loja
--AFTER INSERT
--AS
--BEGIN
--    SET NOCOUNT ON;
--    PRINT 'Um novo registro foi inserido em Loja.';
--END;
--	GO
--CREATE TRIGGER update_loja
--ON Loja
--AFTER UPDATE
--AS
--BEGIN
--    SET NOCOUNT ON;
--    PRINT 'Um registro foi atualizado na tabela Loja.';
--END;
--	GO
--CREATE TRIGGER delete_loja
--ON Loja
--AFTER DELETE
--AS
--BEGIN
--    SET NOCOUNT ON;
--    PRINT 'Um registro foi removido da tabela Loja.';
--END;
--	GO
---- Trigger para Material
--CREATE TRIGGER insercao_material
--ON Material
--AFTER INSERT
--AS
--BEGIN
--    SET NOCOUNT ON;
--    PRINT 'Um novo registro foi inserido na tabela Material.';
--END;
--	GO
--CREATE TRIGGER update_material
--ON Material
--AFTER UPDATE
--AS
--BEGIN
--    SET NOCOUNT ON;
--    PRINT 'Um registro foi atualizado na tabela Material.';
--END;
--	GO
--CREATE TRIGGER delete_material
--ON Material
--AFTER DELETE
--AS
--BEGIN
--    SET NOCOUNT ON;
--    PRINT 'Um registro foi removido da tabela Material.';
--END;
--	GO

--	-- Inserir dados na tabela Usuario
--INSERT INTO Usuario (Cpf_usuario, curso, telefone, email, nome, sexo, data_nascimento)
--VALUES 
--('12345678901', 'Engenharia', '123456789', 'usuario1@email.com', 'Usu�rio 1', 'M', '1990-01-01'),
--('23456789012', 'Ci�ncia da Computa��o', '987654321', 'usuario2@email.com', 'Usu�rio 2', 'F', '1995-05-15'),
--('34567890123', 'Administra��o', '456789012', 'usuario3@email.com', 'Usu�rio 3', 'M', '1988-09-20');
	
--	GO

---- Inserir dados na tabela Loja
--INSERT INTO Loja (preco, estoque)
--VALUES 
--(50.0, 100),
--(30.0, 50),
--(80.0, 200);

--	GO

---- Inserir dados na tabela Assunto
--INSERT INTO Assunto (Cod_assunto, disciplina, descricao_assunto)
--VALUES 
--(1, 'Matem�tica', '�lgebra Linear'),
--(2, 'Hist�ria', 'Idade M�dia'),
--(3, 'Ci�ncia da Computa��o', 'Estrutura de Dados');

--	GO

---- Inserir dados na tabela Material
--INSERT INTO Material (Cod_material, descricao_material, Cod_assunto)
--VALUES 
--(1, 'Livro sobre �lgebra Linear', 1),
--(2, 'Documento sobre a Idade M�dia', 2),
--(3, 'Apresenta��o sobre Estrutura de Dados', 3);

--	GO

---- Inserir dados na tabela Atividade
--INSERT INTO Atividade (Cod_atividade, descricao_atividade, Cod_assunto)
--VALUES 
--(1, 'Exerc�cios de �lgebra Linear', 1),
--(2, 'Pesquisa sobre a Idade M�dia', 2),
--(3, 'Implementa��o de Estrutura de Dados', 3);

--	GO

---- Inserir dados na tabela Desafio
--INSERT INTO Desafio (Cod_desafio, qtd_ponto, Cod_atividade)
--VALUES 
--(1, 10, 1),
--(2, 15, 2),
--(3, 20, 3);

--	GO

---- Inserir dados na tabela Trilha
--INSERT INTO Trilha (Cod_trilha, percurso, Cod_atividade)
--VALUES 
--(1, 'Trilha 1', 1),
--(2, 'Trilha 2', 2),
--(3, 'Trilha 3', 3);

--	GO

---- Inserir dados na tabela Professor
--INSERT INTO Professor (Cpf_professor, data_nascimento_professor, nome, sexo, email, telefone, especializacao)
--VALUES 
--('98765432109', '1975-03-10', 'Professor 1', 'M', 'professor1@email.com', '987654321', 'Matem�tica'),
--('87654321098', '1980-06-20', 'Professor 2', 'F', 'professor2@email.com', '654321098', 'Hist�ria'),
--('76543210987', '1978-12-05', 'Professor 3', 'M', 'professor3@email.com', '543210987', 'Ci�ncia da Computa��o');

--	GO

---- Inserir dados na tabela Mentoria
--INSERT INTO Mentoria (Cod_mentoria, horario, data, descricao_conteudo, Cpf_professor, Cod_assunto)
--VALUES 
--(1, '14:00:00', '2023-01-10', 'Mentoria de Matem�tica', '98765432109', 1),
--(2, '10:30:00', '2023-02-15', 'Mentoria de Hist�ria', '87654321098', 2),
--(3, '16:45:00', '2023-03-20', 'Mentoria de Ci�ncia da Computa��o', '76543210987', 3);

--	GO

-- Utilizar fun��es de agrega��o (SUM, COUNT, AVG, MAX, MIN) com a Loja em estoque e pre�o
--SELECT 
--    COUNT(*) AS Total_Produtos,
--    SUM(estoque) AS Total_Estoque,
--    AVG(CONVERT(DECIMAL(10, 2), preco)) AS Preco_Medio,
--    MAX(preco) AS Preco_Maximo,
--    MIN(preco) AS Preco_Minimo
--FROM 
--    Loja;
--	Aliases e 2 JOIN ON
--	SELECT 
--		U.nome AS NomeUsuario, 
--		M.descricao_conteudo AS DescricaoMentoria
--	FROM 
--		Usuario U
--	JOIN 
--		usuariomentoria UM ON U.Cpf_usuario = UM.Cpf_usuario
--	JOIN 
--    Mentoria M ON UM.Cod_mentoria = M.Cod_mentoria;
---- Inserir dados na tabela usuariomentoria
--INSERT INTO usuariomentoria (Cpf_usuario, Cod_mentoria)
--VALUES
--('12345678901', 1), -- Substitua os valores conforme necess�rio
--('23456789012', 2),
--('34567890123', 3);
--GO

---- Inserir dados na tabela atividadetexto
--INSERT INTO atividadetexto (Cod_atividade, Cpf_usuario)
--VALUES
--(1, '12345678901'), -- Substitua os valores conforme necess�rio
--(2, '23456789012'),
--(3, '34567890123');
--GO

---- Inserir dados na tabela lojamaterial
--INSERT INTO lojamaterial (Cod_produto, Cod_material)
--VALUES
--(1000, 1), -- Substitua os valores conforme necess�rio
--(1010, 2),
--(1020, 3);
--GO

