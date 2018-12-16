namespace ManageTemple.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class updateClientTypes : DbMigration
    {
        public override void Up()
        {
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
            
            DropColumn("dbo.ServiceTypes", "EffectiveDate");
            DropColumn("dbo.ServiceTypes", "ExpirationDate");
        }
        
        public override void Down()
        {
            AddColumn("dbo.ServiceTypes", "ExpirationDate", c => c.DateTime(nullable: false));
            AddColumn("dbo.ServiceTypes", "EffectiveDate", c => c.DateTime(nullable: false));
            DropTable("dbo.ClientTypes");
        }
    }
}
