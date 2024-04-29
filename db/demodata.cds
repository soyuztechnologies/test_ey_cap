namespace mycapapp.db;
using { mycapapp.reuse  } from './reuse';
using { cuid, temporal, managed } from '@sap/cds/common';


context master {
    
    entity student: reuse.address {
        key id: reuse.Guid;
        name: String(80);
        age: Int16;
        brilliant: Boolean;
        semester: Association to one semester; //semester_id
    }

    entity semester {
        key id: reuse.Guid;
        sem: String(32);
        specialization: String(80);
        hod: String(80);
    }

    entity books {
        key id: reuse.Guid;
        name: localized String(50);
        author: String(64);
    }

}

context trans {

    entity subs: cuid, temporal, managed {
        book: Association to one master.books;
        student: Association to one master.student;
    }
    
}
