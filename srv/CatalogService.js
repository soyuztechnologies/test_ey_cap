module.exports = cds.service.impl(async function(){

    const {POs, EmployeeSet} = this.entities;

    this.before('UPDATE', EmployeeSet, async (req,res) => {
        console.log("Aa gaya " + req.data.salaryAmount );
        if(parseFloat(req.data.salaryAmount) > 1000000){
            req.error(500,"Amigo! this salary is not acceptable!");
        }
    });

    this.on('boost', async (req,res) => {
        try {
            //we will be entitied to get FREE PK value
            const ID = req.params[0];
            //Step 1: create object of cds transaction api
            const tx = cds.tx(req);
            //Step 2: update order gross_amount by + 20000
            await tx.update(POs).with({
                GROSS_AMOUNT : {'+=' : 20000}
            }).where(ID);
            //Step 3: Commit work
            tx.commit();
        } catch (error) {
            tx.rollback();
            return "Error " + error.toString();
        }
    });

    this.on('getLargestOrder', async (req,res) => {
        try {
            const tx = cds.tx(req);
            const reply = await tx.read(POs).orderBy({
                "GROSS_AMOUNT": 'desc'
            }).limit(1);
            return reply;
        } catch (error) {
            return "Error : " + error.toString();
        }
    });

});