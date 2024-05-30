const { error } = require("console");
const express = require("express");
const sqlite = require("sqlite3").verbose();

const app = express();
const port = 3000;
const db = new sqlite.Database("database.db");

db.serialize(() => {
	db.run(
		"CREATE TABLE IF NOT EXISTS Usuario (Cpf_usuario CHAR(11) PRIMARY KEY, curso VARCHAR(28) NOT NULL DEFAULT 'Indefinido', telefone VARCHAR(13) NOT NULL, email VARCHAR(80) UNIQUE NOT NULL, nome VARCHAR(50) NOT NULL, sexo CHAR(1) NOT NULL CHECK(sexo='M' OR sexo='F'),data_nascimento DATE NOT NULL)",
	);

	db.run(
		"CREATE TABLE IF NOT EXISTS Professor (Cpf_professor CHAR(11) PRIMARY KEY, data_nascimento_professor DATE NOT NULL, nome VARCHAR(50) NOT NULL, sexo CHAR(1) NOT NULL CHECK (sexo='M' OR sexo='F'), email VARCHAR(80) UNIQUE NOT NULL, telefone VARCHAR(13) NOT NULL, especializacao VARCHAR(28) NOT NULL)",
	);
});

app.use(express.json());

app.get("/", (req, res) => {
	res.send("Estou na API do meu projeto");
});

app.get("/usuarios", (req, res) => {
	db.all("SELECT * FROM Usuarios", (error, rows) => {
		if (error) {
			res.send(error);
		}
		res.send(rows);
	});
});

app.get("/professores", (req, res) => {
	db.all("SELECT * FROM Professores", (error, rows) => {
		if (error) {
			res.send(error);
		}
		res.send(rows);
	});
});

// pegar por ID

app.get("/Usuarios/:Cpf_usuario", (req, res) => {
	const id = req.params.id;
	db.all("SELECT * FROM users WHERE id = ?", id, (error, rows) => {
		if (error) {
			res.send(error);
		}
		res.send(rows);
	});
});

app.post("/users", (req, res) => {
	const { username, password } = req.body;
	console.log(req.body);

	if (
		username == "undefined" ||
		username == "" ||
		password == "undefined" ||
		password == ""
	) {
		res.send("Dados incompletos");
		return;
	} else {
		db.run(
			"INSERT INTO users (username, password) VALUES (?, ?)",
			[username, password],
			(error) => {
				if (error) {
					res.send(error);
					return;
				}
				res.send(`Usuário ${username} cadastrado com sucesso`);
			},
		);
	}
});

app.put("/users/:id", (req, res) => {
	const id = req.params.id;
	const { username, password } = req.body;
	if (
		username == "undefined" ||
		username == "" ||
		password == "undefined" ||
		password == ""
	) {
		res.send("Dados incompletos");
		return;
	} else {
		db.run(
			"UPDATE users SET username = ?, password = ? WHERE id = ?",
			[username, password, id],
			(error) => {
				if (error) {
					res.send(error);
					return;
				}
				res.send(`Usuário ${username} atualizado com sucesso`);
			},
		);
	}
});

app.patch("/users/:id", (req, res) => {
	const id = req.params.id;
	const { username, password } = req.body;
	if (
		username == "undefined" ||
		username == "" ||
		password == "undefined" ||
		password == ""
	) {
		res.send("Dados incompletos");
		return;
	} else {
		db.run(
			"UPDATE users SET username = ?, password = ? WHERE id = ?",
			[username, password, id],
			(error) => {
				if (error) {
					res.send(error);
					return;
				}
				res.send(`Usuário ${username} atualizado com sucesso`);
			},
		);
	}
});

app.delete("/users/:id", (req, res) => {
	const id = req.params.id;
	db.run("DELETE FROM users WHERE id = ?", id, (error) => {
		if (error) {
			res.send(error);
			return;
		}
		res.send(`Usuário ${id} deletado com sucesso`);
	});
});

app.listen(port, () => {
	console.log(`Servidor rodando na porta ${port}`);
});
