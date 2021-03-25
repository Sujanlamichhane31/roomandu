class Contributor{
  String imageUrl;
  String name;
  String description;
  
  
  // ignore: sort_constructors_first
  Contributor({
    this.imageUrl,
    this.name,
    this.description,
  });
}

List<Contributor> Contributors=[
  Contributor(
    imageUrl: '',
    name: 'Bibek Paudel',
    description: 'Node.js Expert',
  ),
  Contributor(
    imageUrl: '',
    name: 'Aabhash Rai',
    description: 'Flutter Developer, Full Stack Developer, Node.js Expert',
  ),
  Contributor(
    imageUrl: '',
    name: 'Sujan Lamichhane',
    description: 'Flutter Designer/ Developer',
  ),
];