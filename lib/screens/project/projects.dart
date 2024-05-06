import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gap/gap.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:student_hub/api/services/api.services.dart';
import 'package:student_hub/models/project.dart';
import 'package:student_hub/providers/providers.dart';
import 'package:student_hub/routes/student_routes.dart';
import 'package:student_hub/utils/empty.dart';
import 'package:student_hub/utils/utils.dart';
import 'package:student_hub/widgets/project_filter.dart';
import 'package:student_hub/widgets/project_card.dart';
import 'package:student_hub/widgets/search_field.dart';

class Projects extends StatefulWidget {
  const Projects({super.key});
  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  final _debouncer = Debouncer(milliseconds: 500);
  final searchController = TextEditingController();
  final String? apiServer = dotenv.env['API_SERVER'];
  final ProjectService projectService = ProjectService();
  bool isLoading = false;

  final int _pageSize = 10;
  String? _searchTerm;
  int? _studentsNeeded;
  int? _proposalsCount;
  int? _projectScopeFlag;

  final PagingController<int, Project> _pagingController =
      PagingController(firstPageKey: 0);

  void _updateSearchTerm(String searchTerm) {
    _debouncer.run(() {
      clearFilters();
      _searchTerm = searchTerm;
      _pagingController.refresh();
    });
  }

  Future<void> updateFilteredProjects(int? studentsNeeded, int? proposalsCount,
      int? projectScopeFlag, UserProvider provider) async {
    clearSearch();
    _studentsNeeded = studentsNeeded;
    _proposalsCount = proposalsCount;
    _projectScopeFlag = projectScopeFlag;
    _pagingController.refresh();
  }

  void clearFilters() {
    _studentsNeeded = null;
    _proposalsCount = null;
    _projectScopeFlag = null;
  }

  void clearSearch() {
    searchController.clear();
    _searchTerm = null;
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final params = {
        'title': _searchTerm,
        'projectScopeFlag': _projectScopeFlag,
        'numberOfStudents': _studentsNeeded,
        'proposalsLessThan': _proposalsCount,
        'page': pageKey / _pageSize + 1,
        'perPage': _pageSize,
      };
      final newItems = await projectService.getProjects(params);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey.toInt());
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(15),
        Row(
          children: [
            Expanded(
              child: SearchBox(
                controller: searchController,
                onChanged: _updateSearchTerm,
              ),
            ),
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              iconSize: 32,
              offset: const Offset(-30, 45),
              color: Theme.of(context).colorScheme.secondaryContainer,
              onSelected: (String value) {
                setState(() {
                  // _selectedMenu = value;
                });
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'Saved',
                  height: 60,
                  onTap: () {
                    Navigator.pushNamed(context, StudentRoutes.projectsSaved);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.favorite,
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(
                                Theme.of(context).brightness == Brightness.dark
                                    ? 1
                                    : .7),
                      ),
                      const Gap(16),
                      Text(
                        'Saved projects',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'Filter',
                  height: 60,
                  onTap: () async {
                    await showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.white,
                        isScrollControlled: true,
                        builder: (ctx) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.8,
                            child: ProjectFilter(
                                apiServer: apiServer,
                                onFilterApplied: updateFilteredProjects),
                          );
                        });
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.filter_alt,
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(
                                Theme.of(context).brightness == Brightness.dark
                                    ? 1
                                    : .7),
                      ),
                      const Gap(16),
                      Text(
                        'Filter projects',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'Cancel', // Giá trị cho mục "Cancel"
                  height: 60,
                  onTap: () {
                    // Xử lý khi chọn "Cancel"
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.cancel,
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(
                                Theme.of(context).brightness == Brightness.dark
                                    ? 1
                                    : .7),
                      ),
                      const Gap(16),
                      Text(
                        'Cancel',
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        const Gap(8),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () => Future.sync(
              () => _pagingController.refresh(),
            ),
            child: PagedListView<int, Project>(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<Project>(
                noItemsFoundIndicatorBuilder: (context) => const Empty(),
                itemBuilder: (context, item, index) => ProjectCard(
                  project: item,
                  projectService: projectService,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
