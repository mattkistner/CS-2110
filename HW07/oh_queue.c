// DO NOT MODIFY THE INCLUDE(S) LIST
#include <stdio.h>
#include "oh_queue.h"

struct Queue oh_queue;

/** push
 * @brief Create a new student and push him
 * onto the OH queue
 * @param studentName pointer to the student's name
 * @param topicName topic the student has a question on
 * @param questionNumber hw question number student has a question on
 * @param pub_key public key used for calculating the hash for customID
 * @return FAILURE if the queue is already at max length, SUCCESS otherwise
 */
int push(const char *studentName, const enum subject topicName, const float questionNumber, struct public_key pub_key){
    if (*studentName == 0 || oh_queue.stats.no_of_people_in_queue == MAX_QUEUE_LENGTH) {
        return FAILURE;
    } else {
        struct Student stu;
        stu.studentData.topic.topicName = topicName;
        stu.studentData.topic.questionNumber = questionNumber;
        my_strncpy(stu.studentData.name, studentName, MAX_NAME_LENGTH);
        stu.studentData.name[MAX_NAME_LENGTH - 1] = 0;
        hash(stu.customID, stu.studentData.name, pub_key);
        stu.queue_number = oh_queue.stats.no_of_people_visited + oh_queue.stats.no_of_people_in_queue;
        oh_queue.students[oh_queue.stats.no_of_people_in_queue] = stu;
        oh_queue.stats.no_of_people_in_queue++;
        OfficeHoursStatus(&oh_queue.stats);
        return SUCCESS;
    }
}

/** pop
 * @brief Pop a student out the OH queue
 * @return FAILURE if the queue is already at empty, SUCCESS otherwise
 */
int pop(void) {
    if (oh_queue.stats.no_of_people_in_queue == 0) {
        return FAILURE;
    } else {
        for (int i = 0; i < oh_queue.stats.no_of_people_in_queue - 1; i++) {
            oh_queue.students[i] = oh_queue.students[i + 1];
        }
        oh_queue.stats.no_of_people_in_queue--;
        oh_queue.stats.no_of_people_visited++;
        OfficeHoursStatus(&oh_queue.stats);
        return SUCCESS;
    }
}

/** group_by_topic
 * @brief Push pointers to students, who match the given topic, to
 * the given array "grouped"
 * @param topic the topic the students need to match
 * @param grouped an array of pointers to students
 * @return the number of students matched
 */
int group_by_topic(struct Topic topic, struct Student *grouped[]) { 
    UNUSED_PARAM(topic);
    UNUSED_PARAM(grouped);

    return 0;
}

/** hash
 * @brief Creates a hash based on pub_key provided
 * @param ciphertext the pointer where you will store the hashed text
 * @param plaintext the original text you need to hash
 * @param pub_key public key used for calculating the hash
 */
void hash(int *ciphertext, char *plaintext, struct public_key pub_key) {
    int *cipherCopy = ciphertext; 
    int len = my_strlen(plaintext);
    for (int i = 0; i < len; i++) {
        char curr = *(plaintext + i);
        *cipherCopy = power_and_mod(curr, pub_key.e, pub_key.n);
        cipherCopy++;
    }
    return;
}

/** update_student
 * @brief Find the student with the given ID and update his topic
 * @param customID a pointer to the id of the student you are trying to find
 * @param newTopic the new topic that should be assigned to him
 * @return FAILURE if no student is matched, SUCCESS otherwise
 */
int update_student(struct Topic newTopic, int *customID) {
    UNUSED_PARAM(newTopic);
    UNUSED_PARAM(customID);
    
    return SUCCESS;
}

/** remove_student_by_name
 * @brief Removes first instance of a student with the given name
 * @param name the name you are searching for
 * @return FAILURE if no student is matched, SUCCESS otherwise
 */
int remove_student_by_name(char *name){
    UNUSED_PARAM(name);

    return SUCCESS;
}

/** remove_student_by_topic
 * @brief Remove all instances of students with the given topic
 * @param topic the topic you are trying to remove from the queue
 * @return FAILURE if no student is matched, SUCCESS otherwise
 */
int remove_student_by_topic(struct Topic topic) {
    UNUSED_PARAM(topic);

    return SUCCESS;
}

/** OfficeHoursStatus
 * @brief Updates the "currentStatus" field based on
 * whether or not all students in the queue have been helped
 * @param resultStats A pointer the OfficeHoursStats variable
 * you are to update
 */
void OfficeHoursStatus(struct OfficeHoursStats* resultStats ){
    UNUSED_PARAM(resultStats);

    return;
}

/*
 * Calculates (b^e)%n without overflow
 */
int power_and_mod(int b, int e, int n) {
    long int currNum = 1;
    for (int i = 0; i < e; i++) {
        currNum *= b;
        if (currNum >= n) {
            currNum %= n;
        }
    }
    return (int) (currNum % n);
}
