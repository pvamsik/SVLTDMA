namespace ManageTemple.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class updatedSTCT2 : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.ServiceTypeClientTypes",
                c => new
                    {
                        ServiceType_id = c.Int(nullable: false),
                        ClientType_ClientTypeID = c.Int(nullable: false),
                    })
                .PrimaryKey(t => new { t.ServiceType_id, t.ClientType_ClientTypeID })
                .ForeignKey("dbo.ServiceTypes", t => t.ServiceType_id, cascadeDelete: true)
                .ForeignKey("dbo.ClientTypes", t => t.ClientType_ClientTypeID, cascadeDelete: true)
                .Index(t => t.ServiceType_id)
                .Index(t => t.ClientType_ClientTypeID);
            
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.ServiceTypeClientTypes", "ClientType_ClientTypeID", "dbo.ClientTypes");
            DropForeignKey("dbo.ServiceTypeClientTypes", "ServiceType_id", "dbo.ServiceTypes");
            DropIndex("dbo.ServiceTypeClientTypes", new[] { "ClientType_ClientTypeID" });
            DropIndex("dbo.ServiceTypeClientTypes", new[] { "ServiceType_id" });
            DropTable("dbo.ServiceTypeClientTypes");
        }
    }
}
