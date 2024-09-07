import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:skicentar_desktop/components/date_picker_field.dart';
import 'package:skicentar_desktop/components/dropdown_field.dart';
import 'package:skicentar_desktop/components/input_field.dart';
import 'package:skicentar_desktop/components/table_wrapper.dart';
import 'package:skicentar_desktop/layouts/master_screen.dart';
import 'package:skicentar_desktop/models/search_result.dart';
import 'package:skicentar_desktop/models/user-role.dart';
import 'package:skicentar_desktop/models/user.dart';
import 'package:skicentar_desktop/providers/user_provider.dart';
import 'package:skicentar_desktop/providers/user_role_provider.dart';
import 'package:skicentar_desktop/screens/user_add_screen.dart';
import 'package:skicentar_desktop/utils/utils.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late UserProvider provider;
  late UserRoleProvider userRoleProvider;
  SearchResult<User>? result;
  List<UserRole> _userRoles = [];

  final _formKey = GlobalKey<FormBuilderState>();
  var filter = {'isUserRoleIncluded': true, 'areUserDetailsIncluded': true};
  final Map<String, dynamic> _initialValue = {};
  final DateFormat formatter = DateFormat('dd MMM yyyy');

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
        "Users",
        Column(
          children: [_buildSearch(), _buildResultView()],
        ),
        false,
        true);
  }

  @override
  void initState() {
    provider = context.read<UserProvider>();
    userRoleProvider = context.read<UserRoleProvider>();
    super.initState();
    provider.addListener(_fetchData);
    _fetchData();
  }

  Future<void> _fetchData() async {
    result = await provider.get(filter: filter);
    var userRoles = await userRoleProvider.get(filter: {});
    _userRoles = userRoles.result;
    if (mounted) {
      setState(() {});
    }
  }

  Widget _buildSearch() {
    return Card(
      margin: const EdgeInsets.all(10.0),
      elevation: 2.0,
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FormBuilder(
          key: _formKey,
          initialValue: _initialValue,
          child: Row(
            children: [
              const InputField(
                name: "emailGTE",
                labelText: "Email",
              ),
              const SizedBox(width: 12),
              DropdownField(
                name: "userRoleId",
                labelText: "Role",
                items: _userRoles
                    .map((item) => DropdownMenuItem<String>(
                        value: item.id.toString(),
                        child: Text(item.name ?? "")))
                    .toList(),
              ),
              const SizedBox(width: 12),
              const DatePickerField(
                name: "dateRegisteredFrom",
                initialValue: null,
                labelText: "Registered from",
              ),
              const SizedBox(width: 12),
              const DatePickerField(
                name: "dateRegisteredTo",
                initialValue: null,
                labelText: "Registered to",
              ),
              const Spacer(),
              if (isFormDirty(_formKey, [
                'emailGTE',
                'userRoleId',
                'dateRegisteredFrom',
                'dateRegisteredTo'
              ]))
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () async {
                    resetForm(
                      _formKey,
                      {
                        'emailGTE': '',
                        'userRoleId': null,
                        'dateRegisteredFrom': null,
                        'dateRegisteredTo': null,
                      },
                    );
                    result = await provider.get(filter: filter);
                    setState(() {});
                  },
                ),
              FilledButton(
                onPressed: _search,
                child: const Text("Search"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _search() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      var formValues =
          Map<String, dynamic>.from(_formKey.currentState?.value ?? {});

      if (formValues['dateRegisteredFrom'] != null) {
        formValues['dateRegisteredFrom'] =
            formatDateTime(formValues['dateRegisteredFrom']);
      }

      if (formValues['dateRegisteredTo'] != null) {
        formValues['dateRegisteredTo'] =
            formatDateTime(formValues['dateRegisteredTo']);
      }
      var combinedFilter = {
        ...filter,
        ...formValues,
      };
      result = await provider.get(filter: combinedFilter);
      setState(() {});
    }
  }

  void navigateToEditPage(BuildContext context, User user) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserAddScreen(user: user)),
    );
  }

  Widget _buildResultView() {
    return TableWrapper(
      columns: const [
        DataColumn(label: Text("Id"), numeric: true),
        DataColumn(label: Text("Email")),
        DataColumn(label: Text("Registration Date")),
        DataColumn(label: Text("Role")),
        DataColumn(label: Text("Verified")),
        DataColumn(label: Text("Actions")),
      ],
      rows: result?.result
              .map((m) => DataRow(cells: [
                    DataCell(Text(m.id.toString())),
                    DataCell(Text(m.email!)),
                    DataCell(Text(formatter.format(m.registrationDate!))),
                    DataCell(Text(m.userRole?.name ?? "")),
                    DataCell(Text(m.isVerified! ? "Yes" : "No")),
                    DataCell(
                      ElevatedButton(
                        onPressed: () => navigateToEditPage(context, m),
                        child: const Text('Edit'),
                      ),
                    ),
                  ]))
              .toList()
              .cast<DataRow>() ??
          [],
    );
  }
}
