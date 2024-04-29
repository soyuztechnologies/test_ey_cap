using { anubhav.db.master } from '../db/datamodel';

service MyService @(path: 'MyService') {

    
    //defintion of the service
    //The implementation will be done in a JS file with same name equality
    function hello(name: String(32)) returns String;
    @readonly
    entity ReadEmployeeSrv as projection on master.employees;
}