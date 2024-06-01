namespace skiCentar.Services.Database;

public partial class UserDetail
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public string LastName { get; set; } = null!;

    public virtual ICollection<User> Users { get; } = new List<User>();

}
