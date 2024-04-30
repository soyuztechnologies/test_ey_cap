using { cappo.cds as cds } from '../db/CDSViews';


service ViewService @(path: 'ViewService') {

    entity POWorklist as projection on cds.CDSViews.POWorklist;

}