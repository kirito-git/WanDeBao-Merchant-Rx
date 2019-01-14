var mysql  = require('mysql');  //调用MySQL模块

//创建一个connection
var connection = mysql.createConnection({    

    host     : 'sqld-gz.bcehost.com',       //主机
    user     : '94d987bf2f50411bbc74c2b89de23efc',            //MySQL认证用户名
    password:'bbe42c81ae3c4da78ca744347b67760c',
    port:   '3306',
    database: 'GfnkdyCDlwTauKTtiaVe'

});

//创建一个connection
connection.connect(function(err){

    if(err){       

        console.log('[query] - :'+err);

        return;

    }

    console.log('[connection connect]  succeed!');

}); 

//执行SQL语句
connection.query('SELECT 1 + 1 AS solution', function(err, rows, fields) {

    if (err) {

        console.log('[query] - :'+err);

        return;

    }

    console.log('The solution is: ', rows[0].solution); 

}); 

//关闭connection
connection.end(function(err){

    if(err){       

        return;

    }

    console.log('[connection end] succeed!');

});