namespace ManageTemple.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class updatedSTCT : DbMigration
    {
        public override void Up()
        {
            //DropTable("dbo.ServiceTypes");
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
            //DropPrimaryKey("dbo.ServiceTypes");
            CreateTable(
                "dbo.ClientTypes",
                c => new
                    {
                        ClientTypeID = c.Int(nullable: false, identity: true),
                        Name = c.String(nullable: false, maxLength: 26),
                        isDefault = c.Boolean(nullable: false),
                        isActive = c.Boolean(nullable: false),
                    })
                .PrimaryKey(t => t.ClientTypeID);
            
            CreateTable(
                "dbo.ServiceTypeClientTypes",
                c => new
                    {
                        ServiceType_ServiceTypeID = c.Int(nullable: false),
                        ClientType_ClientTypeID = c.Int(nullable: false),
                    })
                .PrimaryKey(t => new { t.ServiceType_ServiceTypeID, t.ClientType_ClientTypeID })
                .ForeignKey("dbo.ServiceTypes", t => t.ServiceType_ServiceTypeID, cascadeDelete: true)
                .ForeignKey("dbo.ClientTypes", t => t.ClientType_ClientTypeID, cascadeDelete: true)
                .Index(t => t.ServiceType_ServiceTypeID)
                .Index(t => t.ClientType_ClientTypeID);
            
            /*("dbo.ServiceTypes", "ServiceTypeID", c => c.Int(nullable: false, identity: true));
            AddPrimaryKey("dbo.ServiceTypes", "ServiceTypeID");
            DropColumn("dbo.ServiceTypes", "id");
            DropColumn("dbo.ServiceTypes", "EffectiveDate");
            DropColumn("dbo.ServiceTypes", "ExpirationDate");*/
        }
        
        public override void Down()
        {
            AddColumn("dbo.ServiceTypes", "ExpirationDate", c => c.DateTime(nullable: false));
            AddColumn("dbo.ServiceTypes", "EffectiveDate", c => c.DateTime(nullable: false));
            AddColumn("dbo.ServiceTypes", "id", c => c.Int(nullable: false, identity: true));
            DropForeignKey("dbo.ServiceTypeClientTypes", "ClientType_ClientTypeID", "dbo.ClientTypes");
            DropForeignKey("dbo.ServiceTypeClientTypes", "ServiceType_ServiceTypeID", "dbo.ServiceTypes");
            DropIndex("dbo.ServiceTypeClientTypes", new[] { "ClientType_ClientTypeID" });
            DropIndex("dbo.ServiceTypeClientTypes", new[] { "ServiceType_ServiceTypeID" });
            DropPrimaryKey("dbo.ServiceTypes");
            DropColumn("dbo.ServiceTypes", "ServiceTypeID");
            DropTable("dbo.ServiceTypeClientTypes");
            DropTable("dbo.ClientTypes");
            AddPrimaryKey("dbo.ServiceTypes", "id");
        }
    }
}
