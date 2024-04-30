using { anubhav.db.master, anubhav.db.transaction } from '../db/datamodel';
 //Odata service // CAP framework offers V4 odata service
service CatalogService @(path: 'CatalogService',
//forcing anyone who call catalogservice to present a JWT token
                         requires: 'authenticated-user') {

   //Entityset - end point to perform all the CRUD operation on our data

   entity EmployeeSet @(restrict: [ 
                        { grant: ['READ'], to: 'Viewer', where: 'bankName = $user.BankName' },
                        { grant: ['WRITE'], to: 'Admin' }
                        ])
    as projection on master.employees;
   entity AddressSet as projection on master.address;
   entity ProductSet as projection on master.product;
   entity BusinessPartnerSet as projection on master.businesspartner;
   entity POs @( odata.draft.enabled: true ) as projection on transaction.purchaseorder{
    *,
    case OVERALL_STATUS
        when 'N' then 'New'
        when 'P' then 'Paid'
        when 'A' then 'Approved'
        when 'X' then 'Rejected'
        end as OverallStatus: String(10),
    case OVERALL_STATUS
        when 'N' then 1
        when 'P' then 3
        when 'A' then 3
        when 'X' then 2
        end as Criticality: Integer
   }
    actions{
        @Common.SideEffects:{
            TargetProperties:['in/GROSS_AMOUNT']
        }
        action boost() returns POs;
    }
   ;
   entity POItems as projection on transaction.poitems;
   function getLargestOrder() returns POs;
}