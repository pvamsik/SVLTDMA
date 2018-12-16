namespace ManageTemple.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class ClientType : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.ClientTypes",
                c => new
                    {
                        id = c.Int(nullable: false, identity: true),
                        Name = c.String(nullable: false, maxLength: 26),
                        isDefault = c.Boolean(nullable: false),
                        isActive = c.Boolean(nullable: false),
                    })
                .PrimaryKey(t => t.id);
            
        }
        
        public override void Down()
        {
            DropTable("dbo.ClientTypes");
        }
    }
}
