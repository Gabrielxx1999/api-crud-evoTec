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
		"CREATE TABLE IF NOT EXISTS Assunto (Cod_assunto INTEGER PRIMARY KEY, disciplina VARCHAR(28) NOT NULL, descricao_assunto VARCHAR(100) NOT NULL ",
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

app.get("/Assunto", (req, res) => {
	db.all("SELECT * FROM Assunto", (error, rows) => {
		if (error) {
			res.send(error);
		}
		res.send(rows);
	});
});

// pegar por ID

app.get("/Usuarios/:Cpf_usuario", (req, res) => {
	//A const CPF sigfinifica o ID do determinado usuario e colocar a variavel no parametro do db.all
	const cpf = req.params.Cpf_usuario;
	db.all("SELECT * FROM Usuario WHERE Cpf_usuario = ?", cpf, (error, rows) => {
		if (error) {
			res.send(error);
		}
		res.send(rows);
	});
});

app.get("/Assunto/:Cod_assunto", (req, res) => {
	//A const Cod_assunto sigfinifica o ID do determinado assunto e colocar a variavel no parametro do db.all
	const Codigo = req.Cod_assunto;
	db.all(
		"SELECT * FROM assunto WHERE Cod_assunto = ?",
		cpf_professor,
		(error, rows) => {
			if (error) {
				res.send(error);
			}
			res.send(rows);
		},
	);
});

// APP POST

app.post("/Usuarios", (req, res) => {
	const { Cpf_usuario, curso, telefone, email, nome, sexo, data_nascimento } = req.body;
	console.log(req.body);

	if (!Cpf_usuario || !curso || !telefone || !email || !nome || !sexo || !data_nascimento) {
		res.send("Dados incompletos");
		return;
	} else {
		db.run(
			"INSERT INTO Usuario (Cpf_usuario, curso, telefone, email, nome, sexo, data_nascimento) VALUES (?, ?, ?, ?, ?, ?, ?)",
			[Cpf_usuario, curso, telefone, email, nome, sexo, data_nascimento],
			(error) => {
				if (error) {
					res.send(error);
					return;
				}
				res.send(`Usuário: ${nome} cadastrado com sucesso`);
			},
		);
	}
});

app.post("/Assunto", (req, res) =>) {
	const { Cod_assunto, disciplina, descricao_assunto } = req.body;
	console.log(req.body);

	if (!Cod_assunto || !disciplina || !descricao_assunto) {
		res.send("Dados incompletos");
		return;
	} else {
		db.run(
			"INSERT INTO Assunto (Cod_assunto, disciplina, descricao_assunto) VALUES (?, ?, ?)",
			[Cod_assunto, disciplina, descricao_assunto],
			(error) => {
				if (error) {
					res.send(error);
					return;
				}
				res.send(`Assunto: ${descricao_assunto} cadastrado com sucesso`);
			},
		);
		
	}
}
				 				 
// APP PUT

app.put("/Usuarios/:Cpf_usuario", (req, res) => {
	//A const CPF sigfinifica o ID do determinado usuario e colocar a variavel no parametro do db.run WHERE
	const cpf = req.params.Cpf_usuario;
	const { curso, telefone, email, nome, sexo, data_nascimento } = req.body;
	if (!curso || !telefone || !email || !nome || !sexo || !data_nascimento){
		res.send("Dados incompletos");
		return;
	}else{
		db.run(
			"UPDATE Usuario SET curso = ?, telefone = ?, email = ?, nome = ?, sexo = ?, data_nascimento = ? WHERE Cpf_usuario = ?",
			[curso, telefone, email, nome, sexo, data_nascimento, cpf],
			(error) => {
				if (error) {
					res.send(error);
					return;
				}
				console.log(req.body)
				res.send(`Usuário: ${nome} atualizado com sucesso`);
			},
		);
	}
})

app.put("/Assunto/:Cod_assunto", (req, res) => {
	const Codigo = req.params.Cod_assunto;
	const { disciplina, descricao_assunto } = req.body;
	if (!disciplina || !descricao_assunto){
		res.send("Dados incompletos")
		return;
	}else {
		db.run(
			"UPDATE Assunto SET disciplina = ?, descricao_assunto = ? WHERE Cod_assunto = ?",
			[disciplina, descricao_assunto, Codigo],
			(error) => {
				if (error) {
					res.send(error);
					return;
				}
				res.send(`Assunto: ${descricao_assunto} atualizado com sucesso`);
			},
		)
	}
}

app.patch("/Usuarios/:Cpf_usuario", (req, res) =>{
	//A const CPF sigfinifica o ID do determinado usuario e colocar a variavel no parametro do db.run WHERE
	const cpf = req.params.Cpf_usuario;
	const { curso, telefone, email, nome, sexo, data_nascimento } = req.body;
	if (!curso || !telefone || !email || !nome || !sexo || !data_nascimento){
		res.send("Dados incompletos");
		return;
	}else{
		db.run(
			"UPDATE Usuario SET curso = ?, telefone = ?, email = ?, nome = ?, sexo = ?, data_nascimento = ? WHERE Cpf_usuario = ?", 
			[curso, telefone, email, nome, sexo, data_nascimento, cpf],
			(error) => {
				if (error) {
					res.send(error);
					return;
				}
				res.send(`Usuário: ${nome} atualizado com sucesso`);
			},
		);
	}
})

app.patch("/Assunto/:Cod_assunto", (req, res) =>{
	const Codigo = req.Cod_assunto;
	const { disciplina, descricao_assunto } = req.body;
	if (!disciplina || !descricao_assunto){
		res.send("Dados incompletos")
		return;
	}else {
		db.run(
			"UPDATE Assunto SET disciplina = ?, descricao_assunto = ? WHERE Cod_assunto = ?",
			[disciplina, descricao_assunto, Codigo],
			(error) => {
				if (error) {
					res.send(error);
					return;
				}
				res.send(`Assunto: ${descricao_assunto} atualizado com sucesso`);
			},
		)
	}
})

// APP DELETE

app.delete("/Usuarios/:Cpf_usuario", (req, res) =>{
	//A const CPF sigfinifica o ID do determinado usuario e colocar a variavel no parametro do db.run WHERE
	const cpf = req.params.Cpf_usuario;
	db.run("DELETE FROM Usuario WHERE Cpf_usuario = ?", cpf, (error) => {
		if (error) {
			res.send(error);
			return;
		}
		res.send(`Usuário deletado com sucesso`);
	});
})

app.delete("/Assunto/:Cod_assunto", (req, res) =>{
	const codigo = req.params.Cod_assunto;
	db.run("DELETE FROM Assunto WHERE Cod_assunto = ?", codigo, (error) => {
		if (error) {
			res.send(error);
			return;
		}
		res.send(`Assunto deletado com sucesso`);
	});
}

app.listen(port, () => {
	console.log(`Servidor rodando na porta ${port}`);
});
