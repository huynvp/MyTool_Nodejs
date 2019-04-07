var mysql = require('mysql');
var q = require('q');
var config = require('config');

var config_sql = config.DbConfig;

exports.load = (sql) => {
    var d = q.defer();

    let conn = mysql.createConnection({
        host: config_sql.host,
        port: config_sql.port,
        user: config_sql.user,
        password: config_sql.password,
        database: config_sql.database,
        multipleStatements: true
    });

    conn.connect(function(err) {
        if (err) {
          console.error('error connecting: ' + err.stack);
          return;
        }
        // console.log('connected as id ' + conn.threadId);
      });

    conn.query(sql, (err, rows, fields) => {
        if(err) {
            d.reject(err);
        } else {
            d.resolve(rows);
        }
        conn.end();
    })
    return d.promise;
}

exports.insert = (sql) => {
    var d = q.defer();

    let conn = mysql.createConnection({
        host: config_sql.host,
        port: config_sql.port,
        user: config_sql.user,
        password: config_sql.password,
        database: config_sql.database
    });

    conn.connect(function(err) {
        if (err) {
          console.error('error connecting: ' + err.stack);
          return;
        }
        // console.log('connected as id ' + conn.threadId);
      });

    conn.query(sql, (err, rows, fields) => {
        if(err) {
            d.reject(err);
        } else {
            d.resolve(rows.insertId);
        }
        conn.end();
    })
    return d.promise;
}

exports.update = (sql) => {
    var d = q.defer();

    let conn = mysql.createConnection({
        host: config_sql.host,
        port: config_sql.port,
        user: config_sql.user,
        password: config_sql.password,
        database: config_sql.database,
        multipleStatements: true
    });

    conn.connect(function(err) {
        if (err) {
          console.error('error connecting: ' + err.stack);
          return;
        }
        // console.log('connected as id ' + conn.threadId);
      });

    conn.query(sql, (err, rows, fields) => {
        if(err) {
            d.reject(err);
        } else {
            d.resolve(rows.changedRows);
        }
        conn.end();
    })
    return d.promise;
}

exports.delete = (sql) => {
    var d = q.defer();

    let conn = mysql.createConnection({
        host: config_sql.host,
        port: config_sql.port,
        user: config_sql.user,
        password: config_sql.password,
        database: config_sql.database
    });

    conn.connect(function(err) {
        if (err) {
          console.error('error connecting: ' + err.stack);
          return;
        }
        // console.log('connected as id ' + conn.threadId);
      });

    conn.query(sql, (err, rows, fields) => {
        if(err) {
            d.reject(err);
        } else {
            d.resolve(rows.affectedRows);
        }
        conn.end();
    })
    return d.promise;
}

