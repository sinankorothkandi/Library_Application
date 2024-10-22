import 'package:flutter/material.dart';
import 'package:library_application/data/repositories/author_repository.dart';

void showAddAuthorBottomSheet(BuildContext context) {
  final nameController = TextEditingController();
  final biographyController = TextEditingController();
  final dobController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.amber[900]!, 
              onPrimary: Colors.white, 
              onSurface: Colors.black, 
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      dobController.text =
          "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
    }
  }

  showModalBottomSheet(
    backgroundColor: Colors.white,
    isScrollControlled: true,
    context: context,
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Add Author',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Author Name',
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 201, 201, 201)),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 255, 119, 7)),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please enter author name' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: biographyController,
              maxLines: 6,
              decoration: const InputDecoration(
                hintText: 'Biography',
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 201, 201, 201)),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 255, 119, 7)),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please enter biography' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: dobController,
              readOnly: true,
              decoration: InputDecoration(
                hintText: 'Date of Birth',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => selectDate(context),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 201, 201, 201)),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 255, 119, 7)),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please select date of birth' : null,
            ),
            const SizedBox(height: 36),
            SizedBox(
              height: 45,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState?.validate() ?? false) {
                    final authorRepository = AuthorRepository();
                    final result = await authorRepository.addAuthor(
                      name: nameController.text,
                      birthdate: dobController.text,
                      biography: biographyController.text,
                    );

                    if (result != null) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Author added successfully')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Failed to add author')),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9.0),
                  ),
                ),
                child: const Text(
                  'Add Author',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 26),
          ],
        ),
      ),
    ),
  );
}
