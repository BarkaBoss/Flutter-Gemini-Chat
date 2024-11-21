# DevFest Abuja Flutter + Gemini Showcase

A new Flutter project.

## Getting Started

## Get your API key
>The first thing we need for our AI soup is to get an API key from [Get API Key](https://makersuite.google.com/app/apikey) Create the key and 
> copy the key and keep it safe. **Like all KEYS keep it super safe and private don't share it** 

>create **env.json** file in the root directory of your newly created project
> Add the following code to the env.json file. Replace **your_api_key** with the key from **Google AI studio**

`{
"api_key" :  "your_api_key"
}`

## Install required packages
**flutter pub add google_generative_ai flutter_markdown**

### Congratulations we are done setting up 
![img.png](img.png)

## Get your fingers dirty
change your code in **main.dart** to the following

`void main() {
    runApp(const MyApp());
}

class MyApp extends StatelessWidget {
    const MyApp({super.key});
        @override
        Widget build(BuildContext context) {
        return MaterialApp(
            title: 'DevFest 2024',
            theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
        ),
        home: const Home(),
        );
    }
}`

## Creating our Gemini chat page
>create a folder **screens**
> create a dart file **home.dart**
> create a StatefulWidget class called Home

## Add the following code to the file

`class Home extends StatefulWidget {
    const Home({super.key});

@override
State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
    @override
    Widget build(BuildContext context) {
        return const Placeholder();
    }
}`

## Declare necessary variables
>GenerativeModel is the an instance of the Gemini Model which helps to query the Gemini AI
>ChatSession manages our current chat Gemini

`late final GenerativeModel _gemini;
late final ChatSession _chatSession;
final _messageController = TextEditingController();
final _messageFocusNode = FocusNode();
final _scrollController = ScrollController();`

## Override initState
> We first initialize the Gemini model by selecting the model we want **gemini-pro**
> Next, we set our API key
> Lastly we initialize our chat session to start the chat session

` @override
  void initState() {
    super.initState();
        _gemini = GenerativeModel(
        model: 'gemini-pro',
        apiKey: const String.fromEnvironment('api_key'),
    );
    _chatSession = _gemini.startChat();
}`

### We are getting there

