namespace skiCentar.Services.Database;

public partial class UserDetail
{
    public int Id { get; set; }

    public string Name { get; set; } = null!;

    public string LastName { get; set; } = null!;

    public DateTime? DateOfBirth { get; set; }

    public virtual ICollection<User> Users { get; set; } = new List<User>();
}
