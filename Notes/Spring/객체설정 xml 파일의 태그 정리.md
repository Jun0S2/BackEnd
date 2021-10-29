객체설정 xml 파일의 태그

<bean>

<property ref="???" value="???">

<constructor-arg>

<context:component-scan>


객체설정 애노테이션
@Component

@Service
@Repository
@Controller
@Autowired
@Qualifier
@RequestMapping(value="/board", mothod=RequestMethod.GET)

@GetMapping
@PostMapping
@PutMapping
@DeleteMapping
@RequestParam
@PathVariable

xml객체설정 파일을 xml 극혐이라며 java로 만들 때 사용되는 애노테이션
@Configuration
@Bean
