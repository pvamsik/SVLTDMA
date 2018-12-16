namespace ManageTemple.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class ServiceType1 : DbMigration
    {
        public override void Up()
        {
            DropTable("dbo.ServiceTypes");
            CreateTable(
                "dbo.ServiceTypes",
                c => new
                {
                    ServiceTypeID = c.Int(nullable: false, identity: true),
                    Name = c.String(nullable: false, maxLength: 26),
                    Description = c.String(maxLength: 100),
                    isDefault = c.Boolean(nullable: false),
                    isActive = c.Boolean(nullable: false),
                })
                .PrimaryKey(t => t.ServiceTypeID);
        }
        
        public override void Down()
        {
            
        }
    }
}
