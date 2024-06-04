var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

var items = new[]
{
    "Laptop", "Headphones", "Smartphone", "Camera", "Speaker"
};

app.MapGet("/catalog", () =>
{
    app.Logger.LogInformation("GetCatalog called");
    return items;
})
.WithName("GetCatalog")
.WithOpenApi();

app.Run();
