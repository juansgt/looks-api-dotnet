var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddScoped<ILookRepository, LookRepository>();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();


app.MapGet("/looks", (ILookRepository lookRepository) =>
{
    return lookRepository.GetLooks();
})
.WithName("GetLooks")
.WithOpenApi();

app.Run();

public record Look(string Brand, string Colour);

public interface ILookRepository
{
    IEnumerable<Look> GetLooks();
}

public class LookRepository : ILookRepository
{
    public IEnumerable<Look> GetLooks()
    {
        List<Look> looks = new List<Look>();
        looks.Add(new Look("Prada", "Blue"));
        
        return looks;
    }
}


