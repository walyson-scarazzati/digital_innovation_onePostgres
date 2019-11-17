CREATE TABLE banco (
        numero INTEGER NOT NULL,
        nome VARCHAR(50) NOT NULL,
        ativo BOOLEAN NOT NULL DEFAULT true,
        data_criacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY (numero)
);

CREATE TABLE agencia (
        banco_numero INTEGER NOT NULL,
        numero INTEGER NOT NULL,
        nome VARCHAR(80) NOT NULL,
        ativo BOOLEAN NOT NULL DEFAULT TRUE,
        data_criacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY (banco_numero, numero),
        FOREIGN KEY (banco_numero) REFERENCES banco
);

CREATE TABLE cliente (
        numero BIGSERIAL NOT NULL PRIMARY KEY,
        nome VARCHAR (100) NOT NULL,
        email VARCHAR(250) NOT NULL,
        ativo BOOLEAN NOT NULL DEFAULT TRUE,
        data_criacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE conta_corrente (
        banco_numero INTEGER NOT NULL,
        agencia_numero INTEGER NOT NULL,
        numero BIGINT NOT NULL,
        digito SMALLINT NOT NULL,
        ativo BOOLEAN NOT NULL DEFAULT TRUE,
        data_criacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY (banco_numero, agencia_numero, numero, digito),
        FOREIGN KEY (banco_numero, agencia_numero) REFERENCES agencia (banco_numero,numero)
);

CREATE TABLE cliente_dados_bancarios (
        banco_numero INTEGER NOT NULL,
        agencia_numero INTEGER NOT NULL,
        conta_corrente_numero BIGINT NOT NULL,
        conta_corrente_digito SMALLINT NOT NULL,
        cliente_numero BIGINT NOT NULL,
        ativo BOOLEAN NOT NULL DEFAULT TRUE,
        data_criacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY (banco_numero, agencia_numero, conta_corrente_numero, conta_corrente_digito, cliente_numero),
        FOREIGN KEY (banco_numero, agencia_numero, conta_corrente_numero, conta_corrente_digito) REFERENCES conta_corrente (banco_numero, agencia_numero, numero, digito),
        FOREIGN KEY (cliente_numero) REFERENCES cliente (numero)
);

CREATE TABLE tipo_transacao (
        id SMALLSERIAL NOT NULL PRIMARY KEY,
        nome VARCHAR(50) NOT NULL,
        ativo BOOLEAN NOT NULL DEFAULT TRUE,
        data_criacao TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE cliente_transacao (
        id BIGSERIAL NOT NULL PRIMARY KEY,
        banco_numero INTEGER NOT NULL,
        agencia_numero INTEGER NOT NULL,
        conta_corrente_numero BIGINT NOT NULL,
        conta_corrente_digito SMALLINT NOT NULL,
        cliente_numero BIGINT NOT NULL,
        tipo_transacao_id SMALLINT NOT NULL,
        valor NUMERIC(15,2) NOT NULL,
        FOREIGN KEY (banco_numero, agencia_numero, conta_corrente_numero, conta_corrente_digito, cliente_numero) REFERENCES cliente_dados_bancarios (banco_numero, agencia_numero, conta_corrente_numero, conta_corrente_digito, cliente_numero)
);